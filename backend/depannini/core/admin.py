# core/admin.py
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth.forms import ReadOnlyPasswordHashField
from django import forms


from .models import User, VerificationCode, Assistance


class UserAdmin(BaseUserAdmin):
    """Configure the admin interface for User model"""

    list_display = ('name', 'id',
                    'user_type', 'is_active_assistant')
    list_filter = ('is_staff', 'user_type', 'email_verified', 'phone_verified')

    fieldsets = (
        (None, {'fields': ('phone_number', 'password')}),
        ('Personal info', {'fields': ('name', 'email',
                                    'profile_photo',  'address')}),
        ('Assistant info', {'fields': (
            'user_type', 'service_type', 'vehicle_type', 'is_active_assistant', 'current_lat', 'current_lng')}),
        ('Verification status', {
            'fields': ('email_verified', 'phone_verified')}),
        ('Permissions', {'fields': ('is_active', 'is_staff', 'is_superuser',
                                    'groups', 'user_permissions')}),
    )

    search_fields = ('email', 'name', 'phone_number')
    ordering = ('phone_number',)
    filter_horizontal = ('groups', 'user_permissions',)


class VerificationCodeAdmin(admin.ModelAdmin):
    """Configure the admin interface for VerificationCode model"""
    list_display = ('user', 'code', 'code_type',
                    'created_at', 'expires_at', 'is_used')
    list_filter = ('code_type', 'is_used')
    search_fields = ('user__phone_number', 'user__name', 'code')


# Register the models with admin site
admin.site.register(User, UserAdmin)
admin.site.register(VerificationCode, VerificationCodeAdmin)
admin.site.register(Assistance)
