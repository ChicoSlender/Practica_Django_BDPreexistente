from django.db import models
from django.db.models.fields import BigAutoField, CharField, DateField
from django.db.models.fields.files import FileField
from django.db.models.fields.related import ForeignKey, ManyToManyField, OneToOneField
from django.urls import reverse


class Autor(models.Model):
    id = BigAutoField(primary_key=True)
    nombre = CharField(max_length=255)
    apellido = CharField(max_length=255)
    fecha_nacimiento = DateField(blank=True, null=True)
    sexo = CharField(max_length=1)

    class Meta:
        managed = False
        db_table = 'autor'

    def __str__(self) -> str:
        return self.nombre + ' ' + self.apellido


class Categoria(models.Model):
    id = BigAutoField(primary_key=True)
    nombre = CharField(max_length=100)
    descripcion = CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'categoria'

    def __str__(self) -> str:
        return self.nombre


class Libro(models.Model):
    id = BigAutoField(primary_key=True)
    titulo = CharField(max_length=255)
    descripcion = CharField(max_length=500, blank=True, null=True)
    img = FileField(max_length=255, blank=True, null=True, upload_to='uploads/')
    id_autor = ForeignKey(Autor, models.DO_NOTHING, db_column='id_autor', blank=True, null=True)
    categorias = ManyToManyField(Categoria, through='Categoriasxlibros', through_fields=('id_libro', 'id_categoria'))

    class Meta:
        managed = False
        db_table = 'libro'

    def get_absolute_url(self):
        return reverse('detalle-libro', kwargs={'pk': self.id})


class Categoriasxlibros(models.Model):
    id_libro = OneToOneField('Libro', models.DO_NOTHING, db_column='id_libro', primary_key=True)
    id_categoria = ForeignKey(Categoria, models.DO_NOTHING, db_column='id_categoria')

    class Meta:
        managed = False
        db_table = 'categoriasxlibros'
        unique_together = (('id_libro', 'id_categoria'),)