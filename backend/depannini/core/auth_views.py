# core/auth_views.py
import random
import string
from datetime import timedelta
from depannini import settings

from django.utils import timezone
from django.contrib.auth import get_user_model, authenticate
from django.core.mail import send_mail

from rest_framework import status, views
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken

from google.oauth2 import id_token
from google.auth.transport import requests

import os
from twilio.rest import Client
from dotenv import load_dotenv

from .serializers import (
    UserRegistrationSerializer, EmailVerificationSerializer,
    PhoneVerificationSerializer, PasswordResetRequestSerializer,
    PasswordResetConfirmSerializer, PhoneLoginSerializer,
    EmailLoginSerializer, GoogleLoginSerializer
)
from .models import VerificationCode

User = get_user_model()


def generate_verification_code(length=5):
    """Generate a random verification code"""
    return ''.join(str(random.randint(0, 9)) for _ in range(length))


def send_verification_email(user, code):
    """Send verification code via email"""
    subject = 'Depannini - Email Verification Code'
    message = f'Your verification code is: {code}'
    send_mail(subject, message, settings.EMAIL_HOST_USER, [user.email])


def send_password_reset_email(user, code):
    """Send password reset code via email"""
    subject = 'Depannini - Password Reset Code'
    message = f'Your password reset code is: {code}'
    send_mail(subject, message, settings.EMAIL_HOST_USER, [user.email])


load_dotenv()


def send_sms_verification(phone_number, code):
    # Get credentials from environment variables
    account_sid = os.getenv('TWILIO_ACCOUNT_SID')
    auth_token = os.getenv('TWILIO_AUTH_TOKEN')
    twilio_phone_number = os.getenv('TWILIO_PHONE_NUMBER')

    if not all([account_sid, auth_token, twilio_phone_number]):
        raise ValueError("Twilio credentials not properly configured")

    client = Client(account_sid, auth_token)

    try:
        message = client.messages.create(
            body=f"Your verification code is: {code}",
            from_=twilio_phone_number,
            to=phone_number
        )
        return message.sid is not None
    except Exception as e:
        print(f"Failed to send SMS: {e}")
        return False


def get_tokens_for_user(user):
    """Generate JWT tokens for the user"""
    refresh = RefreshToken.for_user(user)
    return {
        'refresh': str(refresh),
        'access': str(refresh.access_token),
    }


class RegisterView(views.APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = UserRegistrationSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return Response({
                'success': True,
                'user': {
                    'id': user.id,
                    'email': user.email,
                    'name': user.name,
                    'phone_number': user.phone_number,
                    'user_type': user.user_type,
                },
                'tokens': get_tokens_for_user(user)
            }, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class EmailVerificationRequestView(views.APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        if not user.email_verified:
            code = generate_verification_code()
            expiry = timezone.now() + timedelta(minutes=30)
            VerificationCode.objects.create(
                user=user,
                code=code,
                code_type='email',
                expires_at=expiry
            )
            send_verification_email(user, code)
            return Response({
                'success': True,
                'message': 'Email confirmation code sent to your email'
            }, status=status.HTTP_200_OK)
        else:
            return Response({"Email already verified"}, status=status.HTTP_400_BAD_REQUEST)


class EmailVerificationView(views.APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = EmailVerificationSerializer(data=request.data)
        user = request.user
        if serializer.is_valid():
            try:
                verification = VerificationCode.objects.filter(
                    user=user,
                    code_type='email',
                    is_used=False,
                    expires_at__gt=timezone.now()
                ).latest('created_at')

                if verification.code != serializer.validated_data['code']:
                    verification = None

                verification.is_used = True
                verification.save()

                user.email_verified = True
                user.save()

                return Response({
                    'success': True,
                    'message': 'Email successfully verified'
                }, status=status.HTTP_200_OK)
            except:
                return Response({
                    'success': False,
                    'message': 'Invalid verification code'
                }, status=status.HTTP_400_BAD_REQUEST)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class PhoneVerificationView(views.APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        phone_number = request.data.get('phone_number')
        if phone_number:
            # Check if phone number already exists
            if User.objects.filter(phone_number=phone_number).exists():
                return Response({
                    'success': False,
                    'message': 'This phone number is already registered. Please use a different phone number.'
                }, status=status.HTTP_400_BAD_REQUEST)
            code = generate_verification_code()

            send_sms_verification(phone_number, code)
            return Response({"success": True,
                            'code': code})
        return Response({
            "phone_number": "this field is required"},
            status=status.HTTP_400_BAD_REQUEST)


class PhoneVerificationView0(views.APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = PhoneVerificationSerializer(data=request.data)
        if serializer.is_valid():
            try:
                user = User.objects.get(
                    phone_number=serializer.validated_data['phone_number'])
                verification = VerificationCode.objects.filter(
                    user=user,
                    code=serializer.validated_data['code'],
                    code_type='phone',
                    is_used=False,
                    expires_at__gt=timezone.now()
                ).latest('created_at')

                verification.is_used = True
                verification.save()

                user.phone_verified = True
                user.save()

                return Response({
                    'success': True,
                    'message': 'Phone number successfully verified'
                }, status=status.HTTP_200_OK)
            except (User.DoesNotExist, VerificationCode.DoesNotExist):
                return Response({
                    'success': False,
                    'message': 'Invalid verification code'
                }, status=status.HTTP_400_BAD_REQUEST)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class PasswordResetRequestView(views.APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = PasswordResetRequestSerializer(data=request.data)
        if serializer.is_valid():
            try:
                phone_number = serializer.validated_data['phone_number']
                user = User.objects.get(
                    phone_number=phone_number)
                code = generate_verification_code()
                expiry = timezone.now() + timedelta(minutes=30)

                VerificationCode.objects.create(
                    user=user,
                    code=code,
                    code_type='password',
                    expires_at=expiry
                )

                send_sms_verification(phone_number, code)

                return Response({
                    'success': True,
                    'message': 'Password reset code sent to your phone'
                }, status=status.HTTP_200_OK)
            except User.DoesNotExist:
                # For security reasons, still return success even if user doesn't exist
                return Response({
                    'success': False,
                    'message': f'User with phone_number {phone_number} does not exist'
                }, status=status.HTTP_404_NOT_FOUND)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class PasswordResetConfirmView(views.APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = PasswordResetConfirmSerializer(data=request.data)
        if serializer.is_valid():
            try:
                user = User.objects.get(
                    phone_number=serializer.validated_data['phone_number'])
                verification = VerificationCode.objects.filter(
                    user=user,
                    code=serializer.validated_data['code'],
                    code_type='password',
                    is_used=False,
                    expires_at__gt=timezone.now()
                ).latest('created_at')

                verification.is_used = True
                verification.save()

                user.set_password(serializer.validated_data['new_password'])
                user.save()

                # Generate new tokens
                tokens = get_tokens_for_user(user)

                return Response({
                    'success': True,
                    'message': 'Password successfully reset',
                    'tokens': tokens
                }, status=status.HTTP_200_OK)
            except (User.DoesNotExist, VerificationCode.DoesNotExist):
                return Response({
                    'success': False,
                    'message': 'Invalid reset code'
                }, status=status.HTTP_400_BAD_REQUEST)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class EmailLoginView(views.APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = EmailLoginSerializer(data=request.data)
        if serializer.is_valid():
            try:
                phone_number = User.objects.filter(
                    email=serializer.validated_data['email']).first().phone_number
                user = authenticate(
                    request,
                    # Django uses username field for authentication
                    username=phone_number,
                    password=serializer.validated_data['password'])
            except:
                return Response({
                    'success': False,
                    'message': 'Invalid credentials'
                }, status=status.HTTP_401_UNAUTHORIZED)
            if user:
                tokens = get_tokens_for_user(user)
                return Response({
                    'success': True,
                    'tokens': tokens,
                    'user': {
                        'id': user.id,
                        'email': user.email,
                        'name': user.name,
                        'user_type': user.user_type,
                        'email_verified': user.email_verified,
                        'phone_verified': user.phone_verified
                    }
                }, status=status.HTTP_200_OK)
            else:
                return Response({
                    'success': False,
                    'message': 'Invalid credentials'
                }, status=status.HTTP_401_UNAUTHORIZED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class PhoneLoginView(views.APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = PhoneLoginSerializer(data=request.data)
        if serializer.is_valid():
            try:
                user = authenticate(
                    request,
                    # Django uses username field for authentication
                    username=serializer.validated_data['phone_number'],
                    password=serializer.validated_data['password'])
            except:
                return Response({
                    'success': False,
                    'message': 'Invalid credentials'
                }, status=status.HTTP_401_UNAUTHORIZED)

            if user:
                tokens = get_tokens_for_user(user)
                return Response({
                    'success': True,
                    'tokens': tokens,
                    'user': {
                        'id': user.id,
                        'email': user.email,
                        'name': user.name,
                        'user_type': user.user_type,
                        'email_verified': user.email_verified,
                        'phone_verified': user.phone_verified
                    }
                }, status=status.HTTP_200_OK)
            else:
                return Response({
                    'success': False,
                    'message': 'Invalid credentials'
                }, status=status.HTTP_401_UNAUTHORIZED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class PhoneLoginViewOld(views.APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        # Step 1: Request a verification code
        if 'phone_number' in request.data and 'code' not in request.data:
            try:
                user = User.objects.get(
                    phone_number=request.data['phone_number'], phone_verified=True)
                code = generate_verification_code()
                expiry = timezone.now() + timedelta(minutes=5)

                VerificationCode.objects.create(
                    user=user,
                    code=code,
                    code_type='phone',
                    expires_at=expiry
                )

                send_sms_verification(user.phone_number, code)

                return Response({
                    'success': True,
                    'message': 'Verification code sent to your phone'
                }, status=status.HTTP_200_OK)
            except User.DoesNotExist:
                return Response({
                    'success': False,
                    'message': 'Phone number not found or not verified'
                }, status=status.HTTP_404_NOT_FOUND)

        # Step 2: Verify the code and log in
        serializer = PhoneLoginSerializer(data=request.data)
        if serializer.is_valid():
            try:
                user = User.objects.get(
                    phone_number=serializer.validated_data['phone_number'])
                verification = VerificationCode.objects.filter(
                    user=user,
                    code=serializer.validated_data['code'],
                    code_type='phone',
                    is_used=False,
                    expires_at__gt=timezone.now()
                ).latest('created_at')

                verification.is_used = True
                verification.save()

                tokens = get_tokens_for_user(user)

                return Response({
                    'success': True,
                    'tokens': tokens,
                    'user': {
                        'id': user.id,
                        'email': user.email,
                        'name': user.name,
                        'user_type': user.user_type,
                        'email_verified': user.email_verified,
                        'phone_verified': user.phone_verified
                    }
                }, status=status.HTTP_200_OK)
            except (User.DoesNotExist, VerificationCode.DoesNotExist):
                return Response({
                    'success': False,
                    'message': 'Invalid verification code'
                }, status=status.HTTP_400_BAD_REQUEST)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class GoogleLoginView(views.APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = GoogleLoginSerializer(data=request.data)
        if serializer.is_valid():
            token = serializer.validated_data['token']

            try:
                # Specify the CLIENT_ID of your app
                # This should be added to settings.py in a real app
                CLIENT_ID = "YOUR_GOOGLE_CLIENT_ID"
                idinfo = id_token.verify_oauth2_token(
                    token, requests.Request(), CLIENT_ID)

                # Check that the token is valid
                if idinfo['iss'] not in ['accounts.google.com', 'https://accounts.google.com']:
                    return Response({
                        'success': False,
                        'message': 'Invalid token issuer'
                    }, status=status.HTTP_401_UNAUTHORIZED)

                # Get or create user with Google email
                email = idinfo['email']

                try:
                    user = User.objects.get(email=email)
                except User.DoesNotExist:
                    # Create a new user
                    user = User.objects.create_user(
                        email=email,
                        name=idinfo.get('name', ''),
                        password=None  # No password for Google users
                    )
                    user.email_verified = True  # Google has already verified the email
                    user.save()

                # Generate JWT tokens
                tokens = get_tokens_for_user(user)

                return Response({
                    'success': True,
                    'tokens': tokens,
                    'user': {
                        'id': user.id,
                        'email': user.email,
                        'name': user.name,
                        'user_type': user.user_type,
                        'email_verified': user.email_verified,
                        'phone_verified': user.phone_verified
                    }
                }, status=status.HTTP_200_OK)

            except ValueError:
                return Response({
                    'success': False,
                    'message': 'Invalid token'
                }, status=status.HTTP_401_UNAUTHORIZED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ResendVerificationView(views.APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        verification_type = request.data.get('type', 'email')
        user = request.user

        if verification_type == 'email':
            # Resend email verification
            if not user.email_verified:
                code = generate_verification_code()
                expiry = timezone.now() + timedelta(minutes=30)

                VerificationCode.objects.create(
                    user=user,
                    code=code,
                    code_type='email',
                    expires_at=expiry
                )

                send_verification_email(user, code)

                return Response({
                    'success': True,
                    'message': 'Verification email sent'
                }, status=status.HTTP_200_OK)
            else:
                return Response({
                    'success': False,
                    'message': 'Email already verified'
                }, status=status.HTTP_400_BAD_REQUEST)

        elif verification_type == 'phone':
            # Resend phone verification
            if not user.phone_verified and user.phone_number:
                code = generate_verification_code()
                expiry = timezone.now() + timedelta(minutes=30)

                VerificationCode.objects.create(
                    user=user,
                    code=code,
                    code_type='phone',
                    expires_at=expiry
                )

                send_sms_verification(user.phone_number, code)

                return Response({
                    'success': True,
                    'message': 'Verification SMS sent'
                }, status=status.HTTP_200_OK)
            else:
                return Response({
                    'success': False,
                    'message': 'Phone already verified or no phone number provided'
                }, status=status.HTTP_400_BAD_REQUEST)

        return Response({
            'success': False,
            'message': 'Invalid verification type'
        }, status=status.HTTP_400_BAD_REQUEST)


class TokenRefreshView(views.APIView):
    """View for refreshing JWT tokens"""
    permission_classes = [AllowAny]

    def post(self, request):
        refresh_token = request.data.get('refresh')
        if not refresh_token:
            return Response({
                'success': False,
                'message': 'Refresh token is required'
            }, status=status.HTTP_400_BAD_REQUEST)

        try:
            refresh = RefreshToken(refresh_token)
            access_token = str(refresh.access_token)

            return Response({
                'success': True,
                'access': access_token
            }, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({
                'success': False,
                'message': 'Invalid refresh token'
            }, status=status.HTTP_401_UNAUTHORIZED)
