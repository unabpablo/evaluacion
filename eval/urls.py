from django.urls import path

from eval import views
from django.conf.urls import url
app_name = 'registro'

urlpatterns = [ #	path('', views.HomepageView.as_view(), name='homepage'),
	path('collection/<int:pk>/', views.CollectionDetailView.as_view(), name='collection_detail'),
    path('collection/create/', views.CollectionCreate.as_view(), name='collection_create'),

    path('collection/update/<int:pk>/', views.CollectionUpdate.as_view(), name='collection_update'),
    path('collection/delete/<int:pk>/', views.CollectionDelete.as_view(), name='collection_delete'),
    #re_path(r’^[0-9]+)$’, views.CollectionCreate.as_view(), name='collection_detail'),
    path(r'menu', views.hello_world, name='hello_world'),
#path(r'category', views.hola, name='hola'),
path("people/", views.EvalDatatView.as_view(), name='people'),
path("listado/<int:pk>/", views.EvalConfView.as_view(), name='listado'),
path(r'evaluacion', views.createpost, name='evaluacion'),

path(r'evaluaciones', views.evaluacion, name='evaluaciones'),
url(r'register/',views.register,name='register'),
    url(r'user_login/',views.user_login,name='user_login'),
 #url(r'evaluaciones2/',views.evaluacion2,name='evaluaciones2'),
 url(r'Crear_eval/',views.creacion,name='crear_eval'),
  url(r'grafico/(?P<pk>\d+)/$',views.chart,name='realizar_evassl'),
    url(r'graficoAuto/(?P<pk>\d+)/$',views.chartauto,name='autochar'),
    url(r'conf/',views.conf,name='conf'),
        url(r'confnueva/',views.confnueva,name='confnueva'),
                url(r'confnuevaauto/',views.confnuevaautomatica,name='confauto'),
        url(r'tipo_confssss/',views.tipoconfis,name='tipo_configs'),

  url(r'confediciion/(?P<pk>\d+)/$',views.confediciion,name='confediciion'),
    url(r'confmanual/',views.confmanual,name='confmanual'),
    url(r'retry/(?P<pk>\d+)/$',views.retry,name='retry'),
       url(r'drift_list/',views.drift_list,name='drift_list'),
       url(r'etiqueta_auto/(?P<pk>\d+)/$',views.etiqueta_auto,name='etiqueta_auto'),
                url(r'editar/(?P<pk>\d+)/$',views.edit_post,name='editar'),
                                url(r'edit_etiqauto/(?P<pk>\d+)/$',views.edit_etiqauto,name='edit_etiqauto'),
                url(r'edit2/(?P<pk>\d+)/$',views.etiq2,name='etiq2'),
                url(r'edit3/(?P<pk>\d+)/$',views.etiq3,name='etiq3'),
                url(r'eval_data/(?P<pk>\d+)/$',views.eval_data,name='eval_data'),
                                url(r'criterio/',views.criterio,name='criterio'),
                                url(r'mis_graficos/',views.mis_graficos,name='mis_graficos'),
                                                 url(r'listeval/(?P<pk>\d+)/$',views.listeval,name='listeval'),
   #     url(r'modificar/',views.createpost,name='mostrarconf'),
 url(r'editconf/(?P<id_conf>\d+)/$',views.editconf,name='edit_conf'),
  #url(r'nuevaconf/',views.nuevaconf,name='nuevaconf'),
 #path(r'editconf/<int:id_conf>/' ,views.editconf, name='editconf')
]