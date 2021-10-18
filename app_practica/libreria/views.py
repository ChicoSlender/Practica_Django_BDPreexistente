from django.db import models
from django.shortcuts import render
from django.views.generic import TemplateView, ListView, DetailView
from django.urls import reverse_lazy
from .models import *

# Create your views here.

class Index(TemplateView):
    template_name = 'index.html'


class VerLibros(ListView):
    model = Libro

    def get_queryset(self):
        self.titulo = self.request.GET.get("titulo", default="")
        return Libro.objects.filter(titulo__contains=self.titulo)


class DetalleLibro(DetailView):
    model = Libro
