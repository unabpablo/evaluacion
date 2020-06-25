import django_tables2 as tables
from .models import Eval_Data, Eval_Conf

class EvalDataTable(tables.Table):
    Peso1= tables.Column(verbose_name= 'Criterio 1' )
    Peso2= tables.Column(verbose_name= 'Criterio 2' )
    Peso3= tables.Column(verbose_name= 'Criterio 3' )
    Peso4= tables.Column(verbose_name= 'Criterio 4' )
    Peso5= tables.Column(verbose_name= 'Criterio 5' )
    class Meta:
        model = Eval_Data
        template_name = "django_tables2/semantic.html"
        fields = ("conf","Evaluador","Evaluado","Peso1","Peso2","Peso3","Peso4","Peso5","tiempo", )


class EvalConfTable(tables.Table):
    Nombre= tables.Column(verbose_name= 'Nombre Configuracion' )
    fecha= tables.Column(verbose_name= 'Fecha de creacion' )
    tipo_periodo= tables.Column(verbose_name= 'Tipo de periodo' )
    fecha_termino= tables.Column(verbose_name= 'Fecha de termino' )
    metodo_ranking= tables.Column(verbose_name= 'Metodo de evaluacion' )
    class Meta:
        model = Eval_Conf
        template_name = "django_tables2/semantic.html"
        fields = ("Nombre","metodo_ranking","fecha","tipo_periodo","fecha_termino")
      