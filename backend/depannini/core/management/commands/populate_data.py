# core/management/commands/populate_data.py
from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
import random

User = get_user_model()


class Command(BaseCommand):
    help = 'Populate the database with sample data'

    def handle(self, *args, **kwargs):
        # Create sample users
        self.stdout.write('Creating sample users...')

        # Regular users
        regular_users = [
            {
                'email': 'client1@example.com',
                'name': 'client1',
                'password': 'test',
                'user_type': 'client',
                'phone_number': '+1234567890',
                'current_lat': 34.052235,
                'current_lng': -118.243683,
            },
            {
                'email': 'client2@example.com',
                'name': 'client2',
                'password': 'test',
                'user_type': 'client',
                'phone_number': '+1234567891',
                'current_lat': 34.0522235,
                'current_lng': -118.2343683,
            }
        ]

        for user_data in regular_users:
            if not User.objects.filter(email=user_data['email']).exists():
                user = User.objects.create_user(
                    email=user_data['email'],
                    name=user_data['name'],
                    password=user_data['password'],
                    user_type=user_data['user_type'],
                    phone_number=user_data['phone_number'],
                    current_lat=user_data['current_lat'],
                    current_lng=user_data['current_lng']
                )
                user.save()
                self.stdout.write(f"Created user: {user.email}")
            else:
                self.stdout.write(f"User already exists: {user_data['email']}")

        # Assistant users
        locations = [
            {'latitude': 35.12345, 'longitude': -80.98765},
            {'latitude': 35.22345, 'longitude': -80.88765},
            {'latitude': 35.32345, 'longitude': -80.78765},
            {'latitude': 35.42345, 'longitude': -80.68765}
        ]

        service_types = ['towing', 'repair']
        vehicle_types = ['Tow Truck', 'Flatbed Truck',
                         'Service Van', 'Motorcycle']

        assistant_users = [
            {
                "name": "assistant1",
                "password": "test",
                "password_confirm": "test",
                "phone_number": "0658025171",
                "email": 'assistant1@example.com',
                "user_type": "assistant",
                "service_type": "towing",
                "vehicle_type": "truck",
                "current_lat": 34.049345,
                "current_lng": -118.238081,
                "driving_license_cat": "b",
                "driving_license_num": 545433441,
                "driving_license_expiry": "2030-08-20",
                "vehicle_registration_num": 43242341,
                "is_active_assistant": True
            },
            {
                "name": "assistant2",
                "password": "test",
                "password_confirm": "test",
                "phone_number": "0658025172",
                "email": 'assistant2@example.com',
                "user_type": "assistant",
                "service_type": "towing",
                "vehicle_type": "truck",
                "current_lat": 34.036972,
                "current_lng": -118.256427,
                "driving_license_cat": "b",
                "driving_license_num": 545433442,
                "driving_license_expiry": "2030-08-20",
                "vehicle_registration_num": 43242342,
                "is_active_assistant": True
            },
            {
                "name": "assistant3",
                "password": "test",
                "password_confirm": "test",
                "phone_number": "0658025173",
                "email": 'assistant3@example.com',
                "user_type": "assistant",
                "service_type": "towing",
                "vehicle_type": "truck",
                "current_lat": 34.085652,
                "current_lng": -118.232176,
                "driving_license_cat": "b",
                "driving_license_num": 545433443,
                "driving_license_expiry": "2030-08-20",
                "vehicle_registration_num": 43242343,
                "is_active_assistant": True
            },
            {
                "name": "assistant4",
                "password": "test",
                "password_confirm": "test",
                "phone_number": "0658025174",
                "email": 'assistant4@example.com',
                "user_type": "assistant",
                "service_type": "towing",
                "vehicle_type": "truck",
                "current_lat": 34.010234,
                "current_lng": -118.290567,
                "driving_license_cat": "b",
                "driving_license_num": 545433444,
                "driving_license_expiry": "2030-08-20",
                "vehicle_registration_num": 43242344,
                "is_active_assistant": True
            },
            {
                "name": "assistant5",
                "password": "test",
                "password_confirm": "test",
                "phone_number": "0658025175",
                "email": 'assistant5@example.com',
                "user_type": "assistant",
                "service_type": "towing",
                "vehicle_type": "truck",
                "current_lat": 34.127598,
                "current_lng": -118.203875,
                "driving_license_cat": "b",
                "driving_license_num": 545433445,
                "driving_license_expiry": "2030-08-20",
                "vehicle_registration_num": 43242345,
                "is_active_assistant": True
            }
        ]
        for user_data in assistant_users:
            if not User.objects.filter(email=user_data['email']).exists():
                user = User.objects.create_user(
                    email=user_data['email'],
                    name=user_data['name'],
                    password=user_data['password'],
                    user_type=user_data['user_type'],
                    phone_number=user_data['phone_number'],
                    service_type=user_data['service_type'],
                    vehicle_type=user_data['vehicle_type'],
                    is_active_assistant=user_data['is_active_assistant'],
                    current_lat=user_data['current_lat'],
                    current_lng=user_data['current_lng'],
                    driving_license_cat=user_data['driving_license_cat'],
                    driving_license_num=user_data['driving_license_num'],
                    driving_license_expiry=user_data['driving_license_expiry'],
                    vehicle_registration_num=user_data['vehicle_registration_num'],
                )
                user.save()
                self.stdout.write(f"Created assistant: {user.email}")
            else:
                self.stdout.write(
                    f"Assistant already exists: {user_data['email']}")

        self.stdout.write(self.style.SUCCESS(
            'Sample data population complete!'))
