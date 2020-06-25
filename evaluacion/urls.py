from django.contrib import admin
from django.urls import path, include
from django.conf.urls import url 
from eval import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path(r'', include("eval.urls")),

    url(r'^$',views.hello_world,name='index'),
    url(r'^special/',views.special,name='special'),
    url(r'^registro/',include('eval.urls',namespace="app_trip")),
    url(r'^logout/$', views.user_logout, name='logout'),
    url(r'^password/$', views.PasswordResetByUser, name='resetpas'),
 
 
]