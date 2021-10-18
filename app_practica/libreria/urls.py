from django.conf.urls import url
from django.urls import path

from . import views


urlpatterns = [
    path('', views.Index.as_view(), name='index'),
    path('libros/', views.VerLibros.as_view(), name='libros'),
    path('libro/<int:pk>', views.DetalleLibro.as_view(), name='detalle-libro'),
]