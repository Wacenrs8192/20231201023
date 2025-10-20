from django.http import Http404, HttpResponse
from django.shortcuts import render
from django.views import View
from django.views.generic import TemplateView
from django.utils.decorators import method_decorator
from django.views.decorators.http import require_http_methods
from .models import DeveloperProfile, Section


class IndexView(TemplateView):
    """Home page view displaying developer information."""
    template_name = "developer_info/index.html"
    
    def get_context_data(self, **kwargs):
        """Add context data for the template."""
        context = super().get_context_data(**kwargs)
        
        # 获取活跃的开发者信息
        developer = DeveloperProfile.objects.filter(is_active=True).first()
        context['developer'] = developer
        context['developer_name'] = developer.name if developer else "Developer"
        
        # 获取活跃的章节内容
        context['sections'] = Section.objects.filter(is_active=True).order_by('order')
        
        return context


class SectionView(View):
    """API view for retrieving section content."""
    
    @method_decorator(require_http_methods(["GET"]))
    def get(self, request, section_id):
        """Handle GET requests for section content."""
        try:
            section = Section.objects.get(id=section_id, is_active=True)
            return HttpResponse(section.content)
            
        except Section.DoesNotExist:
            raise Http404(f"Section {section_id} not found")
        except (ValueError, TypeError):
            raise Http404("Invalid section ID")
        except Exception as e:
            # Log the error in production
            return HttpResponse("An error occurred", status=500)