from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from datetime import date
from django.utils import timezone
from django.conf import settings
import os
# Create your models here.
def images_path():
    return os.path.join(settings.LOCAL_FILE_DIR, 'archivos')

class Evaluados(models.Model):
    Nombre = models.CharField(max_length=50)  
    
    evaluado = models.BooleanField(default=False, null=True)
    id=models.IntegerField(primary_key=True)
    def __str__(self):
        return self.Nombre

    def __unicode__(self):
        return u'%s %s' % (self.Nombre)

class Expertos(models.Model):
    id=models.IntegerField(primary_key=True)
    Nombre = models.CharField(max_length=50)
    experto = models.BooleanField(default=False, null=True)
    def __str__(self):
        return self.Nombre

    def __unicode__(self):
        return u'%s %s' % (self.Nombre)
        
class Evaluadores(models.Model):
    Nombre = models.CharField(max_length=50) 
    
    peso = models.CharField(max_length=50,blank=True, null=True)
    evaluador = models.BooleanField( null=True,default=False)
    id=models.IntegerField(primary_key=True)
    def __str__(self):
        return self.Nombre

    def __unicode__(self):
        return u'%s %s' % (self.Nombre)
class Eval_Conf(models.Model):
    Nombre = models.CharField(max_length=50)
    fecha = models.DateTimeField(("Date"), default=timezone.now())
    tipo_periodo=models.CharField(max_length=30)
    evaluador=models.ManyToManyField(Evaluadores, blank=True, default = None)
    experto=models.ManyToManyField(Expertos, blank=True, default = None)
    evaluado=models.ManyToManyField(Evaluados, blank=True, default = None)
    booleano=models.BooleanField(default=False, blank=True, null=True)
    fecha_termino = models.DateTimeField(blank=True,null=True)
    metodo_ranking=models.CharField(max_length=30,blank=True, null=True) 
    modo = models.CharField(max_length=50, blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True)
    frecuencia_ranking = models.CharField(max_length=50, blank=True, null=True)
    tolerancia=models.FloatField(max_length=50, default=1)
    umbral=models.FloatField(max_length=50, default=0.05)
    tipo_automatico=models.CharField(max_length=50, )
    img=models.ImageField(blank=True,null=True)
    def __str__(self):
        return self.Nombre

    def __unicode__(self):
        return u'%s %s' % (self.Nombre)

class Conf_Auto(models.Model):
    Nombre = models.CharField(max_length=50)
    tipo_periodo=models.CharField(max_length=30)
    tolerancia=models.FloatField(max_length=50,blank=True, null=True)
    umbral=models.FloatField(max_length=50,blank=True, null=True)

class Collection(models.Model):
    Nombre = models.CharField(max_length=300, blank=True)
    Peso = models.CharField(max_length=300, blank=True)
    Conf = models.ForeignKey(Eval_Conf,  blank=True, null=True,     on_delete=models.SET_NULL)
    note = models.TextField(blank=True)
    created_by = models.ForeignKey(User,
        related_name="collections", blank=True, null=True,
        on_delete=models.SET_NULL)

    def __str__(self):
        return str(self.id)


class CollectionTitle(models.Model):
    """
    A Class for Collection titles.

    """
    collection = models.ForeignKey(Collection,
        related_name="has_titles", on_delete=models.CASCADE)
    Nombre= models.CharField(max_length=500, verbose_name="Nombre")
    Peso = models.CharField(max_length=500,  blank=True, null=True,default='0000000')

    def __str__(self):
        return self.Nombre
class UserProfileInfo(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE)
    cargo= models.CharField(max_length=50)


    portfolio_site = models.URLField(blank=True)
    usuario=models.ForeignKey(Eval_Conf, null=True, on_delete=models.CASCADE, blank=True, default = None)
    profile_pic = models.ImageField(upload_to='profile_pics',blank=True)
    def __str__(self):
        return self.user.username
#def create_profile(sender, **kwargs):
  #  if(kwargs['created']):
    #    user_profile=UserProfileInfo.objects.create(user=kwargs['instance'])
#post_save.connect(create_profile,sender=User    )        



class Eval_Data(models.Model):

    Nombre = models.CharField(max_length=50)
    conf=models.ForeignKey(Eval_Conf, null=True, on_delete=models.CASCADE, blank=True, default = None)
    Peso1 = models.CharField(max_length=50,blank=True, null=True)
    Peso2 = models.CharField(max_length=50,blank=True, null=True)
    Peso3 = models.CharField(max_length=50,blank=True, null=True)
    Peso4 = models.CharField(max_length=50,blank=True, null=True)
    Peso5 = models.CharField(max_length=50,blank=True, null=True)
    booleano=models.BooleanField(default=False, null=True)
    tiempo = models.DateTimeField(null=True, blank=True,auto_now=True)
    Evaluado = models.ForeignKey(Evaluados,       on_delete=models.CASCADE)
    Evaluador = models.ForeignKey(Evaluadores,       on_delete=models.CASCADE)
        










class Criterios(models.Model):
    Nombre= models.CharField(max_length=500, verbose_name="Nombre")


    Peso = models.CharField(max_length=50,blank=True, null=True)

    Conf = models.ForeignKey(Eval_Conf,       on_delete=models.CASCADE)


    def __str__(self):
        #return (self.Nombre, self.Nombre2, self.Nombre3, #self.Nombre4)
        return (self.Nombre+" ")



    def __unicode__(self):
        return u'%s %s' % (self.Nombre)




class Etiquetas(models.Model):
    Etiqueta = models.CharField(max_length=50)

    Peso     = models.CharField(max_length=50)
    conf= models.ForeignKey(Eval_Conf,       on_delete=models.CASCADE)
    criterio = models.ForeignKey(Criterios,       on_delete=models.CASCADE)

    def __str__(self):
        return (self.Peso)


    def __unicode__(self):
        return u'%s %s' % (self.Etiqueta)





class Periodos(models.Model):
    conf = models.ForeignKey(Eval_Conf,       on_delete=models.CASCADE)

    Peso = models.FloatField(max_length=50,blank=True, null=True)




    def __unicode__(self):
        return u'%s %s' % (self.Peso)









class Resultados(models.Model):
    Nombre = models.CharField(max_length=50)

    E_periodo = models.OneToOneField(
        Periodos,
        on_delete=models.CASCADE,
        primary_key=True,
    )

    def __str__(self):
        return self.Nombre


    def __unicode__(self):
        return u'%s %s' % (self.Nombre)
