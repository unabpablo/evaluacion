from background_task import background
from eval.models import *
from django.shortcuts import get_object_or_404

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







@background(schedule=1)
def get_csv(evaluado):
   # Eval_Data.objects.create(Nombre="conf",conf=asd,Evaluado=evaluado,Evaluador=evaluador)
   asd=Eval_Conf.objects.get(id=evaluado)
   print(asd.evaluado.all())

   zxc = asd.evaluado.all()
              
   for b in asd.evaluador.all():
      evaluador=get_object_or_404(Evaluadores,id=b.id)
      print("asas",b.Nombre)
      for a in asd.evaluado.all():
         evaluado=get_object_or_404(Evaluados,id=a.id)
         evaluacion=Eval_Data.objects.create(Nombre="conf",conf=asd,Evaluado=evaluado,Evaluador=evaluador)   

   print("asdsadsadasdasdasd",evaluado)
   return "algo"