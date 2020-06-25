from django import forms
from eval.models import UserProfileInfo
from django.contrib.auth.models import User
from eval.models import *
from django.forms import ModelChoiceField, Select,SelectMultiple,CheckboxSelectMultiple
from django.forms.formsets import formset_factory
from django.forms import inlineformset_factory
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Field, Fieldset, Div, HTML, ButtonHolder, Submit
from .custom_layout_object import *
from multiselectfield import MultiSelectField
from bootstrap_datepicker_plus import DatePickerInput
from django.contrib.admin.widgets import AdminDateWidget
from datetime import date
import datetime
from django.contrib import messages


FRUIT_CHOICES= [
    ('orange', '1'),
    ('cantaloupe', '2'),
    ('mango', '3'),
    ('honeydew', '4'),
    ]

per = (
    ("Evaluación Diaria", ("Evaluación Diaria")),
    ("Evaluación Semanal", ("Evaluación Semanal")),
    ("Evaluación Mensual", ("Evaluación Mensual")),
    ("Evaluación Semestral", ("Evaluación Semestral")),
    ("Evaluación Anual", ("Evaluación Anual"))
    )

perAuto = (
 
    ("Ultima Semana", ("Ultima Semana")),
    ("Ultimos 15 días", ("Ultimos 15 días")),
       ("Ultimos 30 días", ("Ultimos 30 días")),
    )
tipo_eval = (
    ('Metodo 1', ("Metodo 1")),
    ('Metodo 2', ("Metodo 2")),
    ('Metodo 3', ("Metodo 3")),

    )
modo_eval = (
    ('--------', ("--------")),
    ('Automatico', ("Automatico")),
    ('Manual', ("Manual")),


    )
class UploadFileForm(forms.Form):

    file = forms.FileField(widget=forms.ClearableFileInput(attrs={'multiple': True}),label='')



class TipoConfForm(forms.Form):

    tipo_configuracion = forms.ChoiceField(choices=[("Manual", 'Manual'), 
                                                            ("Automática", 'Automática')])









class CollectionTitleForm(forms.ModelForm):

    class Meta:
        model = CollectionTitle
        exclude = ()

CollectionTitleFormSet = inlineformset_factory(
    Collection, CollectionTitle, form=CollectionTitleForm,
    fields=['Nombre'], extra=1, can_delete=True
    )


class CollectionForm(forms.ModelForm):

    class Meta:
        model = Collection
        exclude = ['created_by', ]

    def __init__(self, *args, **kwargs):
        super(CollectionForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_tag = True
        self.helper.form_method = 'post'
        self.helper.form_class = 'form-horizontal'
        self.helper.label_class = 'col-md-3 create-label'
        self.helper.field_class = 'col-md-9'

        self.helper.layout = Layout(
            Div(
                Field('Nombre'),
                Field('Peso'),
                Fieldset('Agregar etiquetas',
                    Formset('titles')),
  
                HTML("<br>"),
                ButtonHolder(Submit('submit', 'Crear Nuevo Criterio')),
                
                )

        )





class UserForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput())
    class Meta():
        model = User
        fields = ('username','first_name','last_name','password','email')
        labels={'username':'Usuario','first_name':'Nombre','last_name':'Apellido','email':'Correo electronico'}
        help_texts = {
            'username': None,
            'email': None,
        }
class UserProfileInfoForm(forms.ModelForm):
     class Meta():
         model = UserProfileInfo
         fields = ('profile_pic','cargo')
         labels={'profile_pic':'Imagen de perfil','cargo':'Cargo'}


class PeriodoForm(forms.Form):
    Peso=forms.CharField(
        label='Book Name',
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Enter Book Name here'
        })
    )






class FrutaForm2(forms.ModelForm):


   # favorite_fruit= forms.CharField(label='Numero de periodos', widget=forms.Select(choices=FRUIT_CHOICES))
    tipo_periodo=per
    metodo_ranking = tipo_eval
    fecha_termino=  forms.DateField(input_formats=['%d-%m-%Y'])
    #fecha_termino = forms.DateField(widget=SelectDateWidget)
    class Meta:
        model= Eval_Conf

        fields= ["Nombre","tipo_periodo","metodo_ranking","evaluador","evaluado","experto","fecha_termino"]
        labels = {
            'Nombre': 'Nombre de la Evaluación', 'evaluador':'Evaluadores', 'evaluado':'Alternativas a evaluar   ','experto':'Expertos','fecha_termino':'Fecha de termino'
        }
        widgets = {
          'tipo__periodo': Select(attrs={'class': 'select'}),
           'fecha_termino': forms.DateInput(format=('%m/%d/%Y'), attrs={'class':'form-control', 'placeholder':'Select a date', 'type':'date'}), 
           'tipo_periodo': forms.Select(choices=per),
            'metodo_ranking': forms.Select(choices=tipo_eval),
      }

    def clean(self):
        cleaned_data = super(FrutaForm2, self).clean()

        field_1 = cleaned_data.get('evaluador')
        field_2 = cleaned_data.get('evaluado')
        field_3 = cleaned_data.get('experto')
        field_4 = cleaned_data.get('fecha_termino')
        if field_1 is None:
            print("errrrrrrrrror")
            raise forms.ValidationError('Ingresar evaluador')  
        if field_2 is None:
            raise forms.ValidationError('Ingresar evaluado')  
        if field_3 is None:
            raise forms.ValidationError('experto')  
        if field_1 is not None and field_2 is not None and field_3 is not None:
            for i in field_1:
                print("asdasdasd",i.Nombre)
                for k in field_2:
                    print("asdasdasd",k.Nombre)
                    if i.Nombre == k.Nombre:
                        # Use None as the first parameter to make it a non-field error.
                        # If you feel is related to a field, use this field's name.
                        raise forms.ValidationError('No puedes evaluarte a ti mismo')   
                for j in field_3:
                    print("asdasdasd",i.Nombre)
            # Values may be None if the fields did not pass previous validations.

                    # If fields have values, perform validation:
                    if j.Nombre == i.Nombre:
                        # Use None as the first parameter to make it a non-field error.
                        # If you feel is related to a field, use this field's name.
                        raise forms.ValidationError('No puedes evaluarte a ti mismo')  
        if field_4 <= timezone.now() or field_4 is None:
            raise forms.ValidationError('Ingresar fecha valida')

        return cleaned_data



class FrutaForm(forms.ModelForm):

    
   # favorite_fruit= forms.CharField(label='Numero de periodos', widget=forms.Select(choices=FRUIT_CHOICES))
    tipo_periodo=per

    #fecha_termino=  forms.DateField(input_formats=['%d-%m-%Y'])
    #fecha_termino = forms.DateField(widget=SelectDateWidget)
    class Meta:
        model= Eval_Conf

        fields= ["evaluador","evaluado","experto","fecha_termino"]
        labels = {
             'evaluador':'Evaluadores', 'evaluado':'Alternativas a evaluar','experto':'Expertos','fecha_termino':'Fecha de termino'
        }
        widgets = {
          'tipo__periodo': Select(attrs={'class': 'select'}),
           'fecha_termino': forms.DateInput(format=('%m/%d/%Y'), attrs={'class':'form-control', 'placeholder':'Select a date', 'type':'date'}), 
           'tipo_periodo': forms.Select(choices=per),

      }

    def clean(self):
        cleaned_data = super(FrutaForm, self).clean()

        field_1 = cleaned_data.get('evaluador')
        field_2 = cleaned_data.get('evaluado')
        field_3 = cleaned_data.get('experto')
        field_4 = cleaned_data.get('fecha_termino')
        if field_1 is None:
            print("errrrrrrrrror")
            raise forms.ValidationError('Ingresar evaluador')  
        if field_2 is None:
            raise forms.ValidationError('Ingresar evaluado')  
        if field_3 is None:
            raise forms.ValidationError('experto')  
        if field_4 is None:
            raise forms.ValidationError('Ingresar Fecha')  
        if field_1 is not None and field_2 is not None and field_3 is not None:
            for i in field_1:
                print("asdasdasd",i.Nombre)
                for k in field_2:
                    print("asdasdasd",k.Nombre)
                    if i.Nombre == k.Nombre:
                        # Use None as the first parameter to make it a non-field error.
                        # If you feel is related to a field, use this field's name.
                        raise forms.ValidationError('No puedes evaluarte a la misma persona')   
                for j in field_3:
                    print("asdasdasd",i.Nombre)
            # Values may be None if the fields did not pass previous validations.

                    # If fields have values, perform validation:
                    if j.Nombre == k.Nombre:
                        # Use None as the first parameter to make it a non-field error.
                        # If you feel is related to a field, use this field's name.
                        raise forms.ValidationError('No puedes evaluar a la misma persona')  
        if field_4 <= timezone.now() or field_4 is None:
            raise forms.ValidationError('Ingresar fecha Valida')

        return cleaned_data


    #class dataForm(forms.ModelForm):

        #CHOICES =lista
    # postal_code = forms.ChoiceField(choices=FRUIT_CHOICES, widget=forms.RadioSelect())
   #     Peso1=models.IntegerField(choices=STATUS_CHOICES, default=1) 
    #    class Meta:
    #        model= Eval_Data
   #         fields= ["Peso1","Peso2","Peso3","booleano"]
   #         labels = {
   #             'Nombre': 'Nombre de la evaluacion','booleano': 'Terminado'
   #         }
   #         widgets = {
    #            'Peso1': forms.Select(choices=STATUS_CHOICES,attrs={'class': 'form-control'}),
     #       }


class CautoForm(forms.ModelForm):

    
   # favorite_fruit= forms.CharField(label='Numero de periodos', widget=forms.Select(choices=FRUIT_CHOICES))
    tipo_periodo=perAuto

    #metodo_ranking = tipo_eval
    #fecha_termino=  forms.DateField(input_formats=['%d-%m-%Y'])
    #fecha_termino = forms.DateField(widget=SelectDateWidget)
    class Meta:
        model= Eval_Conf
        tipo_automatico=modo_eval
        fields= ["tipo_periodo","tolerancia","umbral","tipo_automatico"]
        labels = {
             'tipo_periodo':'Filtro de resultados','tolerancia':'Nivel de Tolerancia','umbral':'Umbral','tipo_automatico':'Tipo de evaluación'
        }
        widgets = {
          'tipo__periodo': Select(attrs={'class': 'select'}),
            'tipo_automatico':forms.Select(choices=modo_eval),
           'tipo_periodo': forms.Select(choices=per),  }
    def clean(self):
        cleaned_data = super(CautoForm, self).clean()

        field_1 = cleaned_data.get('tipo_automatico')
        print(field_1)  
        if field_1 is '--------' :
            print("raise error")
            raise forms.ValidationError('Ingresar tipo de evaluación')       
    
        return cleaned_data


class dataForm(forms.ModelForm):
    tiempo=timezone.now()    
    def __init__(self, round_list, *args, **kwargs):
        super(dataForm, self).__init__(*args, **kwargs)
        self.fields['Peso1'] = forms.ChoiceField(choices=tuple([(name, name) for name in round_list]))
    #Peso1=choices
    class Meta:
        model = Eval_Data
        fields = ('Peso1' ,)

class dataForm2(forms.ModelForm):

    def __init__(self, round_list, *args, **kwargs):
        super(dataForm2, self).__init__(*args, **kwargs)

        self.fields['Peso2'] = forms.ChoiceField(choices=tuple([(name, name) for name in round_list]),)

    class Meta:
        model = Eval_Data
        fields = ('Peso2', )
class dataForm3(forms.ModelForm):

    def __init__(self, round_list, *args, **kwargs):
        super(dataForm3, self).__init__(*args, **kwargs)

        self.fields['Peso3'] = forms.ChoiceField(choices=tuple([(name, name) for name in round_list]))

    class Meta:
        model = Eval_Data
        fields = ('Peso3', )

class dataForm4(forms.ModelForm):

    def __init__(self, round_list, *args, **kwargs):
        super(dataForm4, self).__init__(*args, **kwargs)

        self.fields['Peso4'] = forms.ChoiceField(choices=tuple([(name, name) for name in round_list]))

    class Meta:
        model = Eval_Data
        fields = ('Peso4', )

class dataForm5(forms.ModelForm):

    def __init__(self, round_list, *args, **kwargs):
        super(dataForm5, self).__init__(*args, **kwargs)

        self.fields['Peso5'] = forms.ChoiceField(choices=tuple([(name, name) for name in round_list]))

    class Meta:
        model = Eval_Data
        fields = ('Peso5', )



class EvaluadorChoiceField(ModelChoiceField):

    def label_from_instance(self, obj):
        return '{Nombre}'.format(Nombre=obj.Nombre)
class evaluadorForm(forms.ModelForm):


    Nombre = EvaluadorChoiceField(queryset = Evaluadores.objects.all() )
   

    class Meta:
        model= Evaluadores
        fields= ["Nombre","peso"]
        
        labels = {
            'Nombre': 'Nombre de Evaluador','conf':'Configuración a la que pertenece','peso':'Importancia del Evaluador'
        }
        
        
        
class criterioForm(forms.ModelForm):


    class Meta:
        model= Criterios
        fields= ["Nombre","Peso"]
        
        labels = {
            'Nombre': 'Nombre de Evaluador','Peso':'Importancia del Evaluador'
        }
    def __init__(self, *args, **kwargs):
        super(criterioForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        Button('name', 'value')
            
        
class criteriosForm(forms.Form):
    Nombre=forms.CharField(
        widget=forms.Textarea(attrs={'cols': 20, 'rows': 1})
    )
    peso=forms.FloatField(
        widget=forms.Textarea(attrs={'cols': 20, 'rows': 1})
    )   


class criterios2Form(forms.Form):
    Nombre=forms.CharField(
        widget=forms.Textarea(attrs={'cols': 20, 'rows': 1})
    )
 
BookFormset = formset_factory(criteriosForm, extra=1, max_num=5)
BookFormset2 = formset_factory(criterios2Form, extra=1, max_num=5)
PeriodoFormset = formset_factory(PeriodoForm, extra=1 )
class etiquetaForm(forms.ModelForm):
    class Meta:
        model = Etiquetas
        fields = ["Etiqueta","Peso"]
        
        labels = {
            'Etiqueta': 'Nombre de la etiqueta','Peso':'Peso de la etiqueta',
        }





BOOL_CHOICES = ((True, 'Yes'), (False, 'No'))

class evaluadoForm(forms.ModelForm):

    evaluado= forms.ChoiceField(choices=[(False, 'No'), 
                                                            (True, 'si')])
    #evaluados = EvaluadorChoiceField(queryset = UserProfileInfo.objects.filter(evaluado=True) )


    class Meta:
        model= Evaluados
        fields= ["evaluado"]

        labels = {
            'usuario': 'evaluado'
        }
class evaluadorForm(forms.ModelForm):



   # evaluadores = EvaluadorChoiceField(queryset = UserProfileInfo.objects.filter(evaluador=True) )
    evaluador= forms.ChoiceField(choices=[(False, 'No'), 
                                                            (True, 'Si')])
    class Meta:
        model= Evaluadores
        fields= ["evaluador"]
        


class expertoForm(forms.ModelForm):


    #evaluados = EvaluadorChoiceField(queryset = UserProfileInfo.objects.filter(evaluado=True) )
    experto= forms.ChoiceField(choices=[(False, 'No'), 
                                                            (True, 'Si')])

    class Meta:
        model= Expertos
        fields= ["experto"]
        
class FilterForm(forms.Form):
    evaluador=Evaluadores.objects.all()
    CHOICES= [tuple([x,x]) for x in evaluador]
    #print("aqui estoy")
    #print(CHOICES)


    FILTER_CHOICES = (
        ('time', 'Time'),
        ('timesince', 'Time Since'),
        ('timeuntil', 'Time Untill'),
    )

    Evaluador = forms.ChoiceField(choices = CHOICES)
    
class expForm(forms.ModelForm):
    evaluador=Expertos.objects.all()
    CHOICES= [tuple([x,x]) for x in evaluador]
    #print("aqui estoy")
    #print(CHOICES)




    Nombre = forms.ChoiceField(choices = CHOICES)
    class Meta:
        model= Expertos
        fields= ["Nombre"]



class valuadoForm(forms.Form):
    evaluador=Evaluados.objects.all()
    CHOICES= [tuple([x,x]) for x in evaluador]
    #print("aqui estoy")
    #print(CHOICES)


    Evaluado = forms.ChoiceField(choices = CHOICES,)


class datasForm(forms.ModelForm):
    

  #  item =Etiquetas.objects.filter(pk=1)
  #  lista = []
  #  lista2 = []
  #  for items in item:
     #   lista.append(items.Etiqueta1)
     #   lista.append(items.Etiqueta2)
     #   lista.append(items.Etiqueta3)
     #   lista.append(items.Etiqueta4)

    #for aux in item2:
      #  lista2.append(aux.Nombre)
    #CHOICES =lista
   # postal_code = forms.ChoiceField(choices=FRUIT_CHOICES, widget=forms.RadioSelect())

    class Meta:
        model= Eval_Data
        fields= ["Nombre","Peso1","Peso2","Peso3","Evaluador" , "Evaluado",]
        labels = {
            'Nombre': 'Nombre de la evaluacion',
        }

class widForm(forms.Form):
    evaluador=Evaluados.objects.all()
    CHOICES= [tuple([x,x]) for x in evaluador]
    #print("aqui estoy")
    #print(CHOICES)


    Evaluado = forms.ChoiceField(choices = CHOICES)

class FooForm(forms.Form):
    def __init__(self, foo_choices, *args, **kwargs):
        super(FooForm, self).__init__(*args, **kwargs)
        self.fields['foo'].choices = foo_choices

    foo = forms.ChoiceField(choices=(), required=True)

class decidirForm(forms.Form):       
    Nombre=forms.BooleanField(label='Evaluacion finalizada', required=False 
    )
class confforma(forms.ModelForm):
    class Meta:
        model = Eval_Conf
        fields= ["Nombre","tipo_periodo","metodo_ranking","evaluador","evaluado","experto","fecha_termino"]




class confauto(forms.ModelForm):
    class Meta:
        model = Conf_Auto
        fields= ["Nombre","tipo_periodo","tolerancia","umbral"]



####################################################################################################################################################




class confGlobal(forms.ModelForm):

    class Meta:
        model = Eval_Conf
        fields =["Nombre","tipo_periodo","modo"]
        labels = {'Nombre':'Nombre de la evaluación','tipo_periodo':'Frecuencia evaluación','modo':'Modo de evaluación',}
        widgets = {
          'tipo__periodo': Select(attrs={'class': 'select'}),
           'fecha_termino': forms.DateInput(format=('%m/%d/%Y'), attrs={'class':'form-control', 'placeholder':'Select a date', 'type':'date'}), 
           'tipo_periodo': forms.Select(choices=per),
            'modo': forms.Select(choices=modo_eval),
      }