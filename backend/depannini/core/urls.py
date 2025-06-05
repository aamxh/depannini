# core/urls.py
from django.urls import path


from .auth_views import (
    RegisterView, EmailVerificationView, EmailVerificationRequestView, PhoneVerificationView,
    PasswordResetRequestView, PasswordResetConfirmView,
    EmailLoginView, PhoneLoginView, GoogleLoginView,
    ResendVerificationView
)
from .profile_views import (
    UserProfileView, AssistantProfileView, UpdateLocationView,
    AssistantStatusView, AssistantListView
)
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from .assistance_views import (
    AssistanceRequestView,
    AssistanceListDetailView,
    AcceptAssistanceView,
    AssistanceStatusUpdateView,
    AssistancePriceUpdateView,
    AssistanceRatingUpdateView,
    EndAssistanceView
)

urlpatterns = [
    # Authentication URLs
    path('auth/register/', RegisterView.as_view(), name='register'),  # done
    path('auth/verify-email/', EmailVerificationRequestView.as_view(),
         name='verify-email'),  #
    path('auth/verify-email/confirm/', EmailVerificationView.as_view(),
         name='verify-email-confirm'),  #

    path('auth/verify-phone/', PhoneVerificationView.as_view(),
         name='verify-phone'),  # done

    path(
        'auth/password-reset/',
        PasswordResetRequestView.as_view(), name='password-reset'
    ),  # done
    path(
        'auth/password-reset/confirm/',
        PasswordResetConfirmView.as_view(), name='password-reset-confirm'
    ),  # done
    path(
        'auth/login/email/', EmailLoginView.as_view(),
        name='login-email'
    ),  # done
    path(
        'auth/login/phone/', PhoneLoginView.as_view(),
        name='login-phone'
    ),  # done
    path('auth/login/google/', GoogleLoginView.as_view(),
         name='login-google'),  # not working
    path(
        'auth/resend-verification/',
        ResendVerificationView.as_view(), name='resend-verification'
    ),  # not working
    path('auth/token/refresh/', TokenRefreshView.as_view(),
         name='token-refresh'),  # done
    path(
        'token/', TokenObtainPairView.as_view(),
        name='token_obtain_pair'
    ),  # done
    path(
        'token/refresh/', TokenRefreshView.as_view(),
        name='token_refresh'
    ),  # done

    # Profile URLs
    path(
        'profile/user/', UserProfileView.as_view(), name='user-profile'
    ),
    path(
        'profile/assistant/', AssistantProfileView.as_view(),
        name='assistant-profile'
    ),
    path(
        'profile/update-location/',
        UpdateLocationView.as_view(), name='update-location'
    ),
    path(
        'profile/update-status/',
        AssistantStatusView.as_view(), name='update-status'
    ),
    path('assistants/', AssistantListView.as_view(), name='assistant-list'),

    # Assistance URLs

    path(
        'assistance/request/', AssistanceRequestView.as_view(),
        name='assistance-request'
    ),
    path(
        'assistance/view/', AssistanceListDetailView.as_view(),
        name='assistance-view-all'
    ),
    path(
        'assistance/view/<int:assistance_id>/', AssistanceListDetailView.as_view(),
        name='assistance-view'
    ),
    path(
        'assistance/accept/<int:assistance_id>/', AcceptAssistanceView.as_view(),
        name='assistance-accept'
    ),
    path(
        'assistance/update/status/<int:assistance_id>/', AssistanceStatusUpdateView.as_view(),
        name='status-update'
    ),
    path(
        'assistance/update/price/<int:assistance_id>/', AssistancePriceUpdateView.as_view(),
        name='price-update'
    ),
    path(
        'assistance/update/rating/<int:assistance_id>/', AssistanceRatingUpdateView.as_view(),
        name='rating-update'
    ),
    path(
        'assistance/update/end/<int:assistance_id>/', EndAssistanceView.as_view(),
        name='end-assistance'
    ),
]
