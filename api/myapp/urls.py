from django.urls import path, include
from rest_framework.routers import DefaultRouter
from myapp import views


router = DefaultRouter()
router.register(r'snippets', views.exercise)

urlpatterns = [
    path('', include(router.urls)),
]