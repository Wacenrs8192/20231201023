"""
URL configuration for developer_info application.
"""

from django.urls import path
from .views import IndexView, SectionView

app_name = 'developer_info'

urlpatterns = [
    path('', IndexView.as_view(), name='index'),
    path('api/sections/<int:section_id>/', SectionView.as_view(), name='section_api'),
]