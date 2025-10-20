#!/usr/bin/env python
"""
脚本用于添加开发者信息到数据库
开发者：陈奕鸣 20231201023
"""

import os
import sys
import django

# 设置Django环境
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')

try:
    django.setup()
    
    from developer_info.models import DeveloperProfile, Section
    
    # 添加开发者信息
    developer, created = DeveloperProfile.objects.get_or_create(
        student_id="20231201023",
        defaults={
            "name": "陈奕鸣",
            "bio": "开发者信息系统的创建者",
            "email": "chenyiming@example.com",
            "github_url": "https://github.com/chenyiming",
            "linkedin_url": "https://linkedin.com/in/chenyiming",
            "is_active": True
        }
    )
    
    if created:
        print(f"✅ 成功添加开发者信息: {developer.name} ({developer.student_id})")
    else:
        print(f"ℹ️ 开发者信息已存在: {developer.name} ({developer.student_id})")
    
    # 添加示例章节内容
    sections_data = [
        {
            "title": "个人简介",
            "content": "我是陈奕鸣，学号20231201023。热爱编程和技术开发，专注于Web开发和人工智能领域。",
            "order": 1
        },
        {
            "title": "技术栈",
            "content": "熟练掌握Python、Django、JavaScript、React等开发技术。具备全栈开发能力。",
            "order": 2
        },
        {
            "title": "项目经验",
            "content": "参与过多个Web应用开发项目，包括电商平台、内容管理系统和数据分析工具。",
            "order": 3
        }
    ]
    
    for section_data in sections_data:
        section, created = Section.objects.get_or_create(
            title=section_data["title"],
            defaults={
                "content": section_data["content"],
                "order": section_data["order"],
                "is_active": True
            }
        )
        
        if created:
            print(f"✅ 成功添加章节: {section.title}")
        else:
            print(f"ℹ️ 章节已存在: {section.title}")
    
    print("\n🎉 数据添加完成！")
    
except Exception as e:
    print(f"❌ 错误: {e}")
    sys.exit(1)