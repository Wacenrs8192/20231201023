from django.db import models
from django.urls import reverse


class Section(models.Model):
    """Model representing a content section."""
    
    title = models.CharField(
        max_length=200,
        help_text="Title of the section"
    )
    
    content = models.TextField(
        help_text="Main content of the section"
    )
    
    order = models.PositiveIntegerField(
        default=0,
        help_text="Display order (lower numbers appear first)"
    )
    
    is_active = models.BooleanField(
        default=True,
        help_text="Whether this section is active and visible"
    )
    
    created_at = models.DateTimeField(
        auto_now_add=True,
        help_text="When this section was created"
    )
    
    updated_at = models.DateTimeField(
        auto_now=True,
        help_text="When this section was last updated"
    )
    
    class Meta:
        ordering = ['order', 'created_at']
        verbose_name = "Content Section"
        verbose_name_plural = "Content Sections"
    
    def __str__(self):
        return f"{self.title} (Order: {self.order})"
    
    def get_absolute_url(self):
        return reverse('developer_info:section_api', kwargs={'section_id': self.id})


class DeveloperProfile(models.Model):
    """Model representing developer information."""
    
    name = models.CharField(
        max_length=100,
        help_text="Developer's full name"
    )
    
    student_id = models.CharField(
        max_length=20,
        blank=True,
        help_text="Student ID or identifier"
    )
    
    bio = models.TextField(
        blank=True,
        help_text="Short biography or description"
    )
    
    email = models.EmailField(
        blank=True,
        help_text="Contact email"
    )
    
    github_url = models.URLField(
        blank=True,
        help_text="GitHub profile URL"
    )
    
    linkedin_url = models.URLField(
        blank=True,
        help_text="LinkedIn profile URL"
    )
    
    is_active = models.BooleanField(
        default=True,
        help_text="Whether this profile is active"
    )
    
    created_at = models.DateTimeField(
        auto_now_add=True
    )
    
    updated_at = models.DateTimeField(
        auto_now=True
    )
    
    class Meta:
        verbose_name = "Developer Profile"
        verbose_name_plural = "Developer Profiles"
    
    def __str__(self):
        return self.name