from django.contrib import admin
from .models import Section, DeveloperProfile


@admin.register(Section)
class SectionAdmin(admin.ModelAdmin):
    """Admin configuration for Section model."""
    
    list_display = ('title', 'order', 'is_active', 'created_at', 'updated_at')
    list_filter = ('is_active', 'created_at', 'updated_at')
    search_fields = ('title', 'content')
    ordering = ('order', 'created_at')
    
    fieldsets = (
        ('Basic Information', {
            'fields': ('title', 'content', 'order')
        }),
        ('Status', {
            'fields': ('is_active',)
        }),
        ('Timestamps', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        })
    )
    
    readonly_fields = ('created_at', 'updated_at')


@admin.register(DeveloperProfile)
class DeveloperProfileAdmin(admin.ModelAdmin):
    """Admin configuration for DeveloperProfile model."""
    
    list_display = ('name', 'student_id', 'email', 'is_active', 'created_at')
    list_filter = ('is_active', 'created_at')
    search_fields = ('name', 'student_id', 'email', 'bio')
    
    fieldsets = (
        ('Personal Information', {
            'fields': ('name', 'student_id', 'bio', 'email')
        }),
        ('Social Links', {
            'fields': ('github_url', 'linkedin_url'),
            'classes': ('collapse',)
        }),
        ('Status', {
            'fields': ('is_active',)
        }),
        ('Timestamps', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        })
    )
    
    readonly_fields = ('created_at', 'updated_at')