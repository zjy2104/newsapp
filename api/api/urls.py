"""api URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
#from django.contrib import admin
from django.urls import path
from myapp import views
from myapp.views import sign_up, login, person
from django.urls import path, include
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
#router.register(r'exercise', views.exercise)
router.register(r'comment', views.comment_list)
router.register(r'news', views.new_list)

urlpatterns = [
    #path('admin/', admin.site.urls),
    path('exercise/', views.exercise),
    path('sign/', sign_up),
    #path('admin/', admin.site.urls),
    path('login/', login),
    path('person/', person),
    #path('comment/', views.comment_list),
    path('commentadd/', views.add_comment),
    path('', include(router.urls)),
]
