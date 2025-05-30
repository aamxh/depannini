from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from rest_framework import permissions
from .models import Assistance, User
from .serializers import (
    AssistanceSerializer,
    AssistanceRequestSerializer,
    LocationUpdateSerializer
)
from .utils.geo import haversine
from django.shortcuts import get_object_or_404

from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync

LIGHT_BASE_FARE = 1500
LIGHT_KM_PRICE = 50

HEAVY_BASE_FARE = 3000
HEAVY_KM_PRICE = 150


def calculate_fare(assistance_type, vehicle_type, distance_km):
    if assistance_type == 'towing':
        if vehicle_type == 'light':
            return LIGHT_BASE_FARE + distance_km * LIGHT_KM_PRICE
        return HEAVY_BASE_FARE + distance_km * HEAVY_KM_PRICE
    return 0.0  # for now it's zero in the future maybe will set specific pricing for each repair type


class AssistanceRequestView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AssistanceRequestSerializer

    def post(self, request):
        channel_layer = get_channel_layer()
        if request.user.user_type != 'client':
            return Response({"Success": "False", "Message": "You must be client to request assistance"},
                            status=status.HTTP_403_FORBIDDEN)
        assistance = Assistance.objects.filter(
            client_id=request.user.id,
            status__in=['requested', 'ongoing', 'accepted']
        ).first()
        if assistance:
            return Response({
                "Success": "False",
                "Message": "You have already reqeusted an assistance",
                "assistance_id": assistance.id
            },
                status=status.HTTP_403_FORBIDDEN)
        serializer = AssistanceRequestSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        if serializer.validated_data.get('dropoff', None):
            assistance_type = serializer.validated_data['assistance_type']
            vehicle_type = serializer.validated_data['vehicle_type']
            pickup_lat = serializer.validated_data['pickup']['lat']
            pickup_lng = serializer.validated_data['pickup']['lng']
            dropoff_lat = serializer.validated_data['dropoff']['lat']
            dropoff_lng = serializer.validated_data['dropoff']['lng']
            distance_km = haversine(
                pickup_lat, pickup_lng,
                dropoff_lat, dropoff_lng
            )
            total_price = calculate_fare(
                assistance_type, vehicle_type, distance_km)
            assistance = Assistance.objects.create(
                client_id=request.user.id,
                pickup_lat=pickup_lat,
                pickup_lng=pickup_lng,
                dropoff_lat=dropoff_lat,
                dropoff_lng=dropoff_lng,
                status='requested',
                assistance_type=assistance_type,
                distance_km=distance_km,
                vehicle_type=vehicle_type,
                total_price=total_price
            )
        else:
            assistance = Assistance.objects.create(
                client_id=request.user.id,
                pickup_lat=serializer.validated_data['pickup']['lat'],
                pickup_lng=serializer.validated_data['pickup']['lng'],
                status='requested',
                assistance_type=serializer.validated_data['assistance_type']
            )

        # Find nearby drivers
        all_assistants = User.objects.filter(
            user_type='assistant', is_active_assistant=True, service_type=serializer.validated_data['assistance_type'])
        nearby_assistants = []

        for assistant in all_assistants:
            distance = haversine(
                assistance.pickup_lat, assistance.pickup_lng,
                assistant.current_lat, assistant.current_lng
            )
            if distance <= 5:  # 5km radius
                nearby_assistants.append(
                    {'assistant_id': assistant.id, 'distance': distance})

        # sorting nearby assistants
        sorted_nearby_assistants_list = sorted(
            nearby_assistants, key=lambda x: x["distance"])
        # push notifications
        for assistant in sorted_nearby_assistants_list:
            room_group_name = f'assistant_{assistant['assistant_id']}'
            print(room_group_name)
            try:
                async_to_sync(channel_layer.group_send)(
                    room_group_name,
                    {
                        'type': 'new_request',
                        'assistance_id': assistance.id,
                        'pickup_location': {
                                'lat': serializer.validated_data['pickup']['lat'],
                                'lng': serializer.validated_data['pickup']['lng']
                        },
                        'client': {
                            'id': request.user.id,
                            'name': request.user.name
                        }
                    }
                )
            except Exception as e:
                print(f"Error sending message: {e}")

        return Response({
            'assistance': AssistanceSerializer(assistance).data,
            'nearby_assistants': sorted_nearby_assistants_list
        }, status=status.HTTP_201_CREATED)

# assistance view


class AssistanceListDetailView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, assistance_id=None):
        if request.user.user_type == 'assistant':
            query_set = request.user.assistances_as_assistant
        else:
            query_set = request.user.assistances_as_client
        if not query_set:
            return Response({"message": "failed", "description": "No assistance found"}, status=status.HTTP_404_NOT_FOUND)
        if assistance_id:
            query_set = query_set.filter(id=assistance_id)
        if not query_set:
            return Response({"message": "failed", "description": f'No assistance found with id {assistance_id}'}, status=status.HTTP_404_NOT_FOUND)
        serializer = AssistanceSerializer(query_set, many=True)
        return Response({"message": "success", "Assistance": serializer.data}, status=status.HTTP_302_FOUND)


class AcceptAssistanceView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def patch(self, request, assistance_id):
        channel_layer = get_channel_layer()
        if request.user.user_type != 'assistant' or not request.user.is_active_assistant:
            return Response({"Success": "False", "Message": "You must be an active assistant to accept an assistance"},
                            status=status.HTTP_403_FORBIDDEN)
        try:
            assistance = Assistance.objects.get(id=assistance_id)
            if assistance.status != 'requested':
                return Response(
                    {'error': 'Assistance is not in a requestable state'},
                    status=status.HTTP_409_CONFLICT
                )

            assistance.assistant_id = request.user.id
            assistance.status = 'accepted'
            assistance.save()

            async_to_sync(channel_layer.group_send)(
                f"assistance_{assistance.id}",
                {
                    "type": "assistance_update",  # Maps to method name in consumer
                    "status": "accepted",
                    "assistant": {
                        "id": assistance.assistant.id,
                        "name": assistance.assistant.name
                    }
                }
            )

            return Response(AssistanceSerializer(assistance).data)

        except:
            return Response(
                {'error': 'Assistance not found'},
                status=status.HTTP_404_NOT_FOUND
            )


class AssistanceStatusUpdateView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def patch(self, request, assistance_id):
        assistance_status = request.data['status']
        channel_layer = get_channel_layer()
        try:
            assistance = get_object_or_404(Assistance, id=assistance_id)
            if request.user != assistance.assistant and request.user != assistance.client:
                return Response(
                    {'error': 'Unauthorized update',
                        'description': 'you must be an assistant or a client in this assistant to update it'},
                    status=status.HTTP_403_FORBIDDEN
                )
            if assistance_status not in ['ongoing', 'completed', 'canceled']:
                return Response(
                    {'error': 'Status not valid',
                        'description': 'available choices: ongoing, completed, canceled'},
                    status=status.HTTP_404_NOT_FOUND
                )
            if assistance_status != 'canceled' and request.user.user_type == 'client':
                return Response(
                    {'error': 'Unauthorized update for a client',
                     'description': 'cannot update'},
                    status=status.HTTP_403_FORBIDDEN
                )
            if assistance.status == 'completed' or assistance.status == 'canceled':
                return Response(
                    {'error': 'Not allowed',
                        'description': 'This assistance is no longer editable'},
                    status=status.HTTP_406_NOT_ACCEPTABLE
                )
            if assistance_status == 'completed' and assistance.total_price == 0:
                return Response(
                    {'error': 'Status not accepted',
                        'description': 'Cannot complete assistance before setting its price'},
                    status=status.HTTP_406_NOT_ACCEPTABLE
                )

            assistance.status = assistance_status
            assistance.save()

            async_to_sync(channel_layer.group_send)(
                f"assistance_{assistance.id}",
                {
                    "type": "assistance_update",  # Maps to method name in consumer
                    "status": assistance_status,
                    "assistant": {
                        "id": assistance.assistant.id,
                        "name": assistance.assistant.name
                    },
                    "client": {
                        "id": assistance.client.id,
                        "name": assistance.client.name
                    }
                }
            )
            return Response(AssistanceSerializer(assistance).data, status=status.HTTP_202_ACCEPTED)

        except:
            return Response(
                {'error': 'Assistance not found'},
                status=status.HTTP_404_NOT_FOUND
            )


class AssistancePriceUpdateView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def patch(self, request, assistance_id):
        try:
            assistance_price = request.data['price']
            assistance = get_object_or_404(Assistance, id=assistance_id)
            if request.user != assistance.assistant:
                return Response(
                    {'error': 'Unauthorized update',
                        'description': 'you must be an assistant in this assistant to update price'},
                    status=status.HTTP_403_FORBIDDEN
                )
            if assistance.assistance_type != 'repair':
                return Response(
                    {'error': 'Unauthorized update',
                        'description': 'Assistant can update only assistance of type repair'},
                    status=status.HTTP_403_FORBIDDEN
                )
            assistance.total_price = assistance_price
            assistance.save()
            return Response(AssistanceSerializer(assistance).data, status=status.HTTP_202_ACCEPTED)

        except:
            return Response(
                {'error': 'Assistance not found or you missed the "price" field'},
                status=status.HTTP_404_NOT_FOUND
            )


class AssistanceRatingUpdateView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def patch(self, request, assistance_id):
        try:
            assistance_rating = request.data['rating']
            assistance = get_object_or_404(Assistance, id=assistance_id)
            if request.user != assistance.client:
                return Response(
                    {'error': 'Unauthorized update',
                        'description': 'you must be a client in this assistant to be able to make this update'},
                    status=status.HTTP_403_FORBIDDEN
                )
            if assistance.status != 'completed':
                return Response(
                    {'error': 'Unauthorized update',
                        'description': 'Assistance cannot be rated before completion'},
                    status=status.HTTP_403_FORBIDDEN
                )
            assistance.rating = assistance_rating
            assistance.save()
            return Response(AssistanceSerializer(assistance).data, status=status.HTTP_202_ACCEPTED)

        except:
            return Response(
                {'error': 'Assistance not found or you missed the "rating" field'},
                status=status.HTTP_404_NOT_FOUND
            )


class LocationUpdateView(APIView):
    serializer_class = LocationUpdateSerializer

    def post(self, request, assistance_id):
        channel_layer = get_channel_layer()
        serializer = LocationUpdateSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        try:
            assistance = Assistance.objects.get(
                id=assistance_id, assistant_id=request.user.id)
            if assistance.status not in ['accepted', 'ongoing']:
                return Response(
                    {'error': 'Assistance is not active'},
                    status=status.HTTP_400_BAD_REQUEST
                )

            assistance.assistant.current_lat = serializer.validated_data['lat']
            assistance.assistant.current_lng = serializer.validated_data['lng']
            assistance.assistant.save()

            # Broadcast to client
            async_to_sync(channel_layer.group_send)(
                f"assistance_{assistance.id}",
                {
                    'type': 'location_update',
                    'lat': serializer.validated_data['lat'],
                    'lng': serializer.validated_data['lng']
                }
            )

            return Response({'status': 'location updated'})

        except:
            return Response(
                {'error': 'Assistance not found'},
                status=status.HTTP_404_NOT_FOUND
            )
