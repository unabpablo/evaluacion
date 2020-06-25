from django.shortcuts import render
from django.contrib.auth import authenticate, login, logout, get_user
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import get_object_or_404
from django.urls import reverse
from django.contrib.auth.decorators import login_required
from eval.models import *
from eval.templates import xu,crypto
from fusioncharts import FusionCharts
import matplotlib.pyplot as plt
from django.shortcuts import redirect
from matplotlib.backends.backend_agg import FigureCanvasAgg
from django.core.exceptions import ObjectDoesNotExist

from django.urls import reverse_lazy
from django.views.generic import TemplateView
from django.views.generic.detail import DetailView
from django.views.generic.list import ListView
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from collections import OrderedDict 
from django.db import transaction
from django.http import HttpResponse
import numpy as np
import math
import schedule
import csv
from django.contrib.auth.forms import PasswordChangeForm
from django.db.models import Q
from django.contrib.auth.views import PasswordChangeView
# Create your views here.
from django.contrib.auth import update_session_auth_hash
from background_task import background
from eval.tasks import get_csv
from .tables import EvalDataTable, EvalConfTable
from django import template
from django_tables2 import SingleTableView
from eval.forms import CollectionForm
from .forms import *
import sys
if 'makemigrations' not in sys.argv and 'migrate' not in sys.argv:
    from eval.forms import *
register = template.Library() 

@register.filter(name='has_group') 
def has_group(user, group_name):
    return user.groups.filter(name=group_name).exists() 
##########################################################################
#                           Collection views                             #
##########################################################################

def handle_uploaded_file(f,i):
    with open('media/datos/'+str(i+1)+'.csv', 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)


def tipoconfis(request):
    if request.method == 'POST':

        form = TipoConfForm(request.Post)
        if form.is_valid():
            if form.tipo_configuracion == "Automática":
                return render(request, 'evaluacion.html')
            else:
                return render(request, 'confnueva.html')
    else:
        form=TipoConfForm()
        return render(request,'tipo_modo.html',{'form':form})

class EvalConfView(SingleTableView):
    
    model = Eval_Conf
    table_class = EvalConfTable 
    template_name = 'listado.html'
    def get_object(self):
        # Call the superclass
        object = super(EvalConfView, self).get_object()
        # Record the last accessed date
        asd = Eval_Conf.objects.filters(pk=object)
        print("el objeto es ",object)
        # Return the object
        return asd

class EvalDatatView(SingleTableView):
    model = Eval_Data
    table_class = EvalDataTable 
    template_name = 'dataevaluaciones.html'
    print("el objeto es  asdas")


@login_required
def PasswordResetByUser(request):
    form = PasswordChangeForm(user=request.user)

    if request.method == 'POST':
        form = PasswordChangeForm(user=request.user, data=request.POST)
        if form.is_valid():
            form.save()
            update_session_auth_hash(request, form.user)
            messages.success(request,"Contraseña cambiada exitosamente")
            return HttpResponseRedirect(reverse('index'))

        else:
            return render(request, 'registro/changepassword.html', {
        'form': form,
    })            
    else:
        return render(request, 'registro/changepassword.html', {
        'form': form,
    })



class HomepageView(TemplateView):
    template_name = "base.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['collections'] = Collection.objects.order_by('id')
        return context

class CollectionDetailView(DetailView):
    model = Collection
    template_name = 'collection_detail.html'

    def get_context_data(self, **kwargs):
        context = super(CollectionDetailView, self).get_context_data(**kwargs)
        return context


class CollectionCreate(CreateView):
    model = Collection
    template_name = 'collection_create.html'
    form_class = CollectionForm
    success_url = None

    def get_context_data(self, **kwargs):
        data = super(CollectionCreate, self).get_context_data(**kwargs)
        if self.request.POST:
            data['titles'] = CollectionTitleFormSet(self.request.POST)
           # user = User.objects.get(id=kwargs['pk'])
        else:
            data['titles'] = CollectionTitleFormSet()
           # user = User.objects.get(id=kwargs['pk'])

        return data

    def form_valid(self, form):
        context = self.get_context_data()
        titles = context['titles']
        with transaction.atomic():
            form.instance.created_by = self.request.user
            form.instance.Conf = Eval_Conf.objects.latest('id')
            print("asdasd",form.instance.Conf)    
            self.object = form.save()
            if titles.is_valid():
                titles.instance = self.object
                       
                titles.save()

                return super(CollectionCreate, self).form_valid(form)
        

    def get_success_url(self):
        return reverse_lazy('registro:collection_create',)
        

    # @method_decorator(login_required)
    # def dispatch(self, *args, **kwargs):
    #     return super(CollectionCreate, self).dispatch(*args, **kwargs)


class CollectionUpdate(UpdateView):
    model = Collection
    form_class = CollectionForm
    template_name = 'collection_create.html'

    def get_context_data(self, **kwargs):
        data = super(CollectionUpdate, self).get_context_data(**kwargs)
        if self.request.POST:
            data['titles'] = CollectionTitleFormSet(self.request.POST, instance=self.object)
        else:
            data['titles'] = CollectionTitleFormSet(instance=self.object)
        return data

    def form_valid(self, form):
        context = self.get_context_data()
        titles = context['titles']
        with transaction.atomic():
            form.instance.created_by = self.request.user
            self.object = form.save()
            if titles.is_valid():
                titles.instance = self.object
                titles.save()
        return super(CollectionUpdate, self).form_valid(form)

    def get_success_url(self):
        return reverse_lazy('registro:collection_detail', kwargs={'pk': self.object.pk})

    # @method_decorator(login_required)
    # def dispatch(self, *args, **kwargs):
    #     return super(CollectionUpdate, self).dispatch(*args, **kwargs)


class CollectionDelete(DeleteView):
    model = Collection
    template_name = 'confirm_delete.html'
    success_url = reverse_lazy('registro:homepage')







def job(self, asd,evaluado,evaluador):
    print("algo")
    Eval_Data.objects.create(Nombre="conf",conf=asd,Evaluado=evaluado,Evaluador=evaluador)


@login_required 
def confnueva(request):


 # Archivo para crear las configuraciones
    if request.method == 'POST':
        form = confGlobal(request.POST or None)
        #exp=expForm(request.POST)
        if form.is_valid():
            form.save()
            asd=form.save(commit=False)
            if asd.modo =="Automatico":

#               
                return redirect('registro:confauto',)
            else:
                return redirect('registro:confmanual',)
        else:
            messages.success(request,"Error en la configuración")
            storage =messages.get_messages(request)
            return render(request,'confnueva.html',{'form':form,'messages':storage}) 
    else:
        form=confGlobal()

        return render(request,'confnueva.html',{'form':form,})













@login_required 
def confnuevaautomatica(request):
    i=0
    form = CautoForm(request.POST or None) # Archivo para crear las configuraciones
    status="Creado"
    files = request.FILES.getlist('file')
    conf=Eval_Conf.objects.last()
    evaluado=Evaluados.objects.last()
    evaluador=Evaluadores.objects.last()
    cuenta_lineas= 0
        #exp=expForm(request.POST)
    if form.is_valid() :
                #asd=form.save(commit=False)
       

        asd=form.save(commit=False)
        conf.tolerancia=asd.tolerancia
        conf.umbral=asd.umbral
        conf.status=status
        conf.save()
        try:
            os.mkdir(settings.MEDIA_DIR+'/datos/'+str(conf.Nombre)+'/')
        except OSError:
            print ("Creation of the directory  failed")
        else:
            print ("Successfully created the directory ")
        for count, x in enumerate(request.FILES.getlist("files")):
            def process(f):
                with open('media/datos/'+str(conf.Nombre)+'/'+str(i)+'.csv', 'wb+') as destination:
                
                    for chunk in f.chunks():
                        destination.write(chunk)
            i=i+1       
            process(x)
        if asd.tipo_automatico =='--------':

            print("algo ---")
            messages.success(request,"Elige una opción valida")
            return render(request,'confauto.html',{'form':form,})
        messages.success(request, "configuracion creada exitosamente") 
       # with open(os.path.join(settings.MEDIA_DIR,""+str(1)+".csv")) as f:
         #   reader = csv.reader(f)
        #    for row in reader:
        #        if cuenta_lineas == 0:
        #            cuenta_lineas=cuenta_lineas+1
        #        elif cuenta_lineas == 1:
        #            cuenta_lineas=cuenta_lineas+1
        #        else:
        #            _, created = Eval_Data.objects.get_or_create(
         #           Nombre=row[1],
        #            conf=conf,
        #            Evaluado=evaluado,
        #            Evaluador=evaluador
       #             #print("estoy dentro")
      #              )

        return HttpResponseRedirect(reverse('registro:etiqueta_auto', kwargs={"pk": conf.id}))

 



    return render(request,'confauto.html',{'form':form,})






#tipos de usuario
@login_required 
def hello_world(request):
   
    storage=messages.get_messages(request)
    usuario = get_user(request)
    data = UserProfileInfo.objects.filter(user=usuario.id)    
   # for datas in data:
  #      print(datas.evaluado)


    return render(request, 'hello_world.html', {'messages':storage})

@login_required
#trabajando aqui

def conf(request):
    usuario = get_user(request)
    context = []
    form=Evaluados.objects.all()
    for ass in form:

        context=ass.Nombre
    if request.method == "POST":
        selected_item = get_object_or_404(Evaluados, pk=request.POST.get('item_id'))
        print(selected_item)

        return render(request,'conf.html',{'form':context})
            
    else:
        form=Evaluados.objects.all()
        #return render(request,'conf.html')
        return render(request,'conf.html',{'form':context})


@login_required
def editconf(request,id_conf):
    conf=Eval_Conf.objects.get(id=id_conf)
    if(request.method=='GET'):
        form=FrutaForm(instance=Eval_Conf)
    else:
        form=FrutaForm(request.POST,instance=Eval_Conf)
        if(form.is_valid()):
            form.save()
        return redirect('conf:conf')
    return render(request,'conf.html',{'form':form,})

@login_required
def evaluacion(request):
    storage =messages.get_messages(request)
    return render(request,'criterio.html',{'messages':storage})

#def evaluacion2(request):
      
        

@login_required
def creacion(request):
        usuario = get_user(request)
        try:
                evaluado=Evaluadores.objects.get(id=usuario.id)
               #conf=Eval_Data.objects.filter(Evaluador=evaluado,booleano=False)
                confi=Eval_Conf.objects.filter(evaluador=evaluado)
        except ObjectDoesNotExist:
                evaluado = None
              #  conf= None
                confi = None
        #evaluado=get_object_or_404(Evaluados,id=usuario.id)
        #evaluado=Evaluados.objects.get(id=usuario.id)
        
        
        

            
        if request.method == 'POST':
                conf=Eval_Data.objects.filter(Evaluador=evaluado,booleano=False)
            #if(request.POST["send"] >"0"):
             #   variable=request.POST["send"]
              #  post=get_object_or_404(Eval_Conf,id=variable)
                #print(obj)
              #  form=FrutaForm(request.POST,instance=post) 
               # if(form.is_valid()):
                #    post = form.save(commit =False)
               #     post.Nombre=request.user
                #    post.save()
               # return render(request, 'editar.html',{'form':conf})
            

                return render(request,'listeval.html',{'form':conf})

        else:
            
            
            return render(request,'Realizar_eval.html', { 'form':confi})

@login_required
def listeval(request,pk):
        usuario = get_user(request)
        try:
                evaluado=Evaluadores.objects.get(id=usuario.id)
               #conf=Eval_Data.objects.filter(Evaluador=evaluado,booleano=False)
                conf=Eval_Data.objects.filter(Evaluador=evaluado,conf_id=pk,booleano=False)
        except ObjectDoesNotExist:
                evaluado = None
              #  conf= None
                confi = None
        #evaluado=get_object_or_404(Evaluados,id=usuario.id)
        #evaluado=Evaluados.objects.get(id=usuario.id)
        
        
        

            
        if request.method == 'POST':
                conf=Eval_Data.objects.filter(Evaluador=evaluado,conf_id=pk,booleano=False)
            #if(request.POST["send"] >"0"):
             #   variable=request.POST["send"]
              #  post=get_object_or_404(Eval_Conf,id=variable)
                #print(obj)
              #  form=FrutaForm(request.POST,instance=post) 
               # if(form.is_valid()):
                #    post = form.save(commit =False)
               #     post.Nombre=request.user
                #    post.save()
               # return render(request, 'editar.html',{'form':conf})
            

                return render(request,'listeval.html',{'form':conf})

        else:
            
            
            return render(request,'Realizar_eval.html', { 'form':conf})







            
 
@login_required
def index(request):
    return render(request,'registro/index.html')
@login_required
def special(request):
    return HttpResponse("You are logged in !")
@login_required
def user_logout(request):
    logout(request)
    return HttpResponseRedirect(reverse('index'))
@login_required
def register(request):


   
    if  request.user.is_authenticated:
        user=get_user(request)
        if user.groups.filter(name = 'admin').exists():
            registered = False      
            if request.method == 'POST':
                user_form = UserForm(data=request.POST)
                experto_form=expertoForm(data=request.POST)
                evaluado_form=evaluadoForm(data=request.POST)
                evaluador_form=evaluadorForm(data=request.POST)
                profile_form = UserProfileInfoForm(data=request.POST)

                if user_form.is_valid() and profile_form.is_valid() and evaluado_form.is_valid() and evaluador_form.is_valid() and experto_form.is_valid():
                    user = user_form.save()
                    user.set_password(user.password)
                    user.save()
                    print("entre maybe")
                    asd=evaluado_form.save(commit=False)
                    if(asd.evaluado== False):
                        print("nada")
                    else:
                        profile = profile_form.save(commit=False)
                        asd.Nombre=user.first_name+' '+ profile.cargo
                        asd.evaluado=True
                        asd.id=user.id
                        asd.save()

                    evaluador=evaluador_form.save(commit=False)
                    if(evaluador.evaluador==False):
                        print("nada")

                    else:
                        profile = profile_form.save(commit=False)
                        evaluador.Nombre=user.first_name+' '+ profile.cargo
                        evaluador.evaluador=True
                        evaluador.id=user.id
                        evaluador.save()

                    experto=experto_form.save(commit=False)
                    if experto.experto==False:
                        print("asa")

                    else:
                        profile = profile_form.save(commit=False)
                        experto.Nombre=user.first_name+' '+ profile.cargo
                        experto.experto=True
                        experto.id=user.id
                        experto.save()

                    profile = profile_form.save(commit=False)
                    profile.user = user
                    if 'profile_pic' in request.FILES:
                        print('found it')
                        profile.profile_pic = request.FILES['profile_pic']
                    profile.save()
                    registered = True
                
                else:
                    print(user_form.errors,profile_form.errors)
            else:
                user_form = UserForm()
                profile_form = UserProfileInfoForm()
                evaluado_form=evaluadoForm()
                experto_form=expertoForm()
                evaluador_form=evaluadorForm()
            
            return render(request,'registro/registration.html',
                                {'user_form':user_form,
                                'profile_form':profile_form,
                                'registered':registered,'usuario':evaluado_form,'evaluador':evaluador_form,'experto':experto_form})
        else:

            return render(request,'registro/login.html')
def user_login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(username=username, password=password)
        if user:
            if user.is_active:
                login(request,user)
                return HttpResponseRedirect(reverse('index'))
            else:
                return HttpResponse("Your account was inactive.")
        else:
            print("Someone tried to login and failed.")
            print("They used username: {} and password: {}".format(username,password))
            return HttpResponse("Invalid login details given")
    else:
        return render(request, 'registro/login.html', {})
#EVALUACION personalizada
@login_required
def createpost(request):
        usuario = get_user(request)
        print("id es ",usuario.id)
       
        #experto=get_object_or_404(Expertos,id=usuario.id)
        #data = UserProfileInfo.objects.filter(user=usuario.id)   
        try:
            experto=Expertos.objects.get(pk=usuario.id)
            conf=Eval_Conf.objects.filter(experto=experto,booleano =False)
            conf2=Eval_Conf.objects.all()
        except ObjectDoesNotExist:
            experto= None
            conf = None
        context={'conf':conf}
        evaluado=evaluadorForm(request.POST) 
        
       
        if request.method == 'POST':
            coleccion=Eval_Conf.objects.filter(experto=experto)
            if(request.POST["send1"] >"0"):
                variable=request.POST["send1"]
               # obj=get_object_or_404(Eval_Conf,id=variable)
                return render(request, 'mostrarconf.html',{'conf':conf})
            
            if(coleccion is None):
                return render(request, 'evaluacion.html',)
                
            else:
                return render(request, 'evaluacion.html', {'conf':coleccion}) 
        else:
            #evaluado=evaluadoForm() 
            #evaluador=evaluadorForm()
            print("asas")
           # coleccions=Eval_Conf.objects.filter(experto=coleccion)
            conf2=Eval_Conf.objects.all()

                
            if(conf is None):
                return render(request, 'evaluacion.html',{'conf':conf,'conf2':conf2})
                
            else:
                return render(request, 'evaluacion.html', {'conf':conf,'conf2':conf2})
@login_required
#grafico
def chart(request,pk):
    usuario = get_user(request)
    id=usuario.id
    conf=Eval_Conf.objects.get(id=pk)
    criterios=Collection.objects.filter(Conf=conf)
    all_data= {}
    eval_id= []
    evaluado=Evaluados.objects.filter(eval_conf=conf)
    data =Eval_Data.objects.filter(conf=conf)
    cant=len(evaluado)

    lista= []
    list2=[]
    t = 1
    aux=0
    aux2=0
    decision=[]
    evaluadores= []
    datos_cant=0
    for i in  data:
        eval_id.append(i.Evaluado)
    for m in eval_id:
        list2.append(m.Nombre)

    listas2=set(list2)
    for x in conf.evaluador.all():
        evaluadores.append(x.Nombre)
        print("evaluadores son",x.Nombre)
    for x in conf.evaluado.all():

        print("evaluados son",x.Nombre)
        datos_cant=datos_cant+1
    tamanoeval=len(evaluadores)
    datos=datos_cant*len(evaluadores)
    #for i in range(0,tamanoeval,1):
    k=0
    lists = [[] for _ in range(datos_cant)]
    #print("la cantidad de datos es",len(evaluadores))
   # for i in data:
      #  for k in evaluadores:
         #   print("EL VALOR DE K ES",i.Evaluador)
          #  if str(i.Evaluador)==str(k):
       #      print("MAYBE?")
        
    coleccion=Collection.objects.filter(Conf_id=pk)
    collecion=[]
    crit1=coleccion[0]
    crit2=coleccion[1]
    uniqueList = []
    Listacrit = []
    for z in range(0,len(coleccion),1):
        Listacrit.append(coleccion[z].Nombre)

    print("lista de crit es ",Listacrit)
    stat=1
    data_eval=Eval_Data.objects.filter(conf_id=pk)
    for n in data_eval:
        lists[k].append(n)
        if stat==4 or stat==8 or stat ==12 or stat==16:
            k=k+1
        stat=stat+1
    print("lista de crit es asdsadas",lists)

    for elem in list2:
        if elem not in uniqueList:
            uniqueList.append(elem)



    
    dataSource = {}
    dataSource['chart'] = {
            "caption": "Ranking",
            "subCaption" : "    ",
            "xAxisName": "Evaluados",
            "yAxisName": "Puntuacion",
		 "theme": "zune"

        }

    # The data for the chart should be in an array where each element of the array is a JSON object
    # having the `label` and `value` as key value pair.
    dato=xu.evaluacion(pk)
    dataSource['data'] = []
    # Iterate through the data in `Revenue` model and insert in to the `dataSource['data']` list.
    contador=len(uniqueList)
    print ("data",data[0])
    print("intento",list2[0])
    print("contador es",contador)
    t = []
    datass2 = []   
    for key in range(0,int(contador),1):
        data= {}
        datass = []
 
        
        data['value'] =round(dato[key],2)
        data['label'] =uniqueList[key]
        dataSource['data'].append(data)
        datass.append(round(dato[key],2))
        datass2.append(uniqueList[key])
        print(datass2)


    # Create an object for the Column 2D chart using the FusionCharts class constructor
    column2D = FusionCharts("column2d", "ex1" , "600", "350", "chart-1", "json", dataSource)
    return render(request, 'index.html', {'output': column2D.render(),'form':coleccion,'form2':data_eval,'form3':lists, 'form4':datass,'form5':datass2})
@login_required    
def edit_post(request,pk):
    usuario=get_user(request)
    evaluado=Expertos.objects.get(pk=usuario.id)
    conf=Eval_Conf.objects.get(id=pk)
    crit=Collection.objects.filter(Conf=conf)
    if request.method == 'GET':
        formset = BookFormset2()
        form2=decidirForm()
        form=FrutaForm2(instance=conf)
        
        context= {'form':crit,'form2':conf}
        return render(request,'editar.html', {'form':crit,'formset':formset})
        
    elif request.method == 'POST':
        formset = BookFormset2(request.POST)
        if formset.is_valid():
            for form in formset:
                
                # extract name from each form and save
                name = form.cleaned_data.get('Nombre')
                
                # save book instance
                if name:
                    conf=Eval_Conf.objects.latest('id')

                    CollectionTitle(Nombre=name,collection=crit[0]).save()
           # CollectionTitle()
       # messages.success(request,"etiquetas creadas correctamente")
        conf.status="Activo"
        conf.save()
        return HttpResponseRedirect(reverse('registro:etiq3',
        kwargs={"pk": crit[0].id}))
              # once all books are saved, redirect to book list view
def etiq2(request,pk):
    url = 'http://127.0.0.1:8000/edit2/'
    var= str(pk)
    url=url+var
    print(url)
    usuario=get_user(request)
    evaluado=Expertos.objects.get(pk=usuario.id)
    conf=Eval_Conf.objects.get(id=pk)
    crit=Collection.objects.filter(Conf=conf)
    if request.method == 'GET':
        formset = BookFormset2()
        form2=decidirForm()
        form=FrutaForm2(instance=conf)
        
        context= {'form':crit,}
        return render(request,'etiqueta2.html', {'form':crit,'formset':formset})
        
    elif request.method == 'POST':
        formset = BookFormset2(request.POST)
        if formset.is_valid():

                for form in formset:
                    try:      
                        # extract name from each form and save
                        name = form.cleaned_data.get('Nombre')
                        
                        # save book instance
                        if name:
                            conf=Eval_Conf.objects.latest('id')
                            CollectionTitle(Nombre=name,collection=crit[1]).save()
                # CollectionTitle()
                        #messages.success(request,"etiquetas creadas correctamente")
                        return HttpResponseRedirect(reverse('registro:etiq3',
                kwargs={"pk": conf.id}))
                    except:
                        messages.success(request,"etiquetas creadas correctamente")
                        return HttpResponseRedirect(reverse('registro:evaluacion',))
def etiq3(request,pk):


    usuario=get_user(request)
    evaluado=Expertos.objects.get(pk=usuario.id)
    pk2=int(pk)+1
    pk3=int(pk)+2
    crit=Collection.objects.get(pk=pk2)
    conf=Eval_Conf.objects.get(collection=crit)

    try:
        crit2=Collection.objects.get(pk=pk3)
    except:
        crit2= None
   # conf2=Eval_Conf.objects.get()



  
    if request.method == 'GET':
        formset = BookFormset2()
        form2=decidirForm()

        return render(request,'etiqueta3.html', {'form':crit,'formset':formset})
        
    elif request.method == 'POST':

        formset = BookFormset2(request.POST)
        
        if formset.is_valid():
            for form in formset:
                
                # extract name from each form and save
                name = form.cleaned_data.get('Nombre')
                
                # save book instance
                if name:
                    print(conf.booleano)
                    conf.booleano = False
                    conf.save()
                    print(conf.booleano)
                    CollectionTitle(Nombre=name,collection=crit).save()
           # CollectionTitle()
        if crit2 is None:
            messages.success(request,"etiquetas creadas correctamente")
            return HttpResponseRedirect(reverse('registro:evaluacion',))
                        
        else:
            return HttpResponseRedirect(reverse('registro:etiq3',
        kwargs={"pk": crit.id}))   
   

@login_required  
def eval_data(request,pk):
    usuario = get_user(request) 
    id=pk
    #experto=get_object_or_404(id,id=usuario.id)
    post=Eval_Data.objects.get(pk=pk)
    conf=post.conf
    print("confi",conf)
   # print(conf)
    criterios=Collection.objects.latest('id')
    criterio=Collection.objects.filter(Conf=conf)
    #print(criterios)
    etiquetas= []  
    etiquetas2= []   
    etiquetas3= []  
    etiquetas4=[]
    etiquetas5=[]

    etiquetas=CollectionTitle.objects.filter(collection=criterio[0])
  
    try:
     
        etiquetas2=CollectionTitle.objects.filter(collection=criterio[1])
    except:
        etiquetas2=etiquetas
  
    try:
        etiquetas3=CollectionTitle.objects.filter(collection=criterio[2])
    except:
        etiquetas3=etiquetas
    try:
        etiquetas4=CollectionTitle.objects.filter(collection=criterio[3])
    except:
        etiquetas4=etiquetas
    try:
        etiquetas5=CollectionTitle.objects.filter(collection=criterio[4])
    except:
        etiquetas5=etiquetas
   # for i in etiquetas:

       # print(i.Etiqueta1
       # asd = [rnd.Nombre for rnd in criterios]
    for i in criterio:
        print("criterio",i.Nombre)
    if request.method=='POST':
        etiqueta=etiquetaForm(request.POST)
        form = dataForm(etiquetas,request.POST,instance=post)
        form3 =dataForm2(etiquetas2,request.POST,instance=post)
        form4 =dataForm3(etiquetas3,request.POST,instance=post)
        form5 =dataForm4(etiquetas4,request.POST,instance=post)
        form6=dataForm5(etiquetas5,request.POST,instance=post)

        if(form.is_valid() ):
            form = dataForm(etiquetas,request.POST, instance=post)
            form.save()

        if(form3.is_valid() ):
            form3 = dataForm2(etiquetas2,request.POST, instance=post)
            form3.save()
        if(form4.is_valid()):
            form4 = dataForm3(etiquetas3,request.POST, instance=post)
            form4.save()
        if(form5.is_valid()):
            form5 = dataForm4(etiquetas4,request.POST, instance=post)
            form5.save()  
        if(form6.is_valid()):
            form6 = dataForm5(etiquetas5,request.POST, instance=post)
            form6.save() 
        print("asdkjsadkljasldkjal")
        post.booleano = False
        post.save()
        messages.success(request,"Evaluacion evaluada exitosamente")
        return HttpResponseRedirect(reverse('registro:crear_eval', ))

    else:
        etiqueta=etiquetaForm()
        form=dataForm(etiquetas,instance=post)
        form3=dataForm2(etiquetas2,instance=post)
        form4=dataForm3(etiquetas3,instance=post)
        form5=dataForm4(etiquetas4,instance=post)
        form6=dataForm5(etiquetas5,instance=post)
        context= {'form':form,'post':post}
        return render(request,'eval_data.html',{'form':form,'form2':criterio,'form3':form3,'form4':form4,'form5':form5,'form6':form6})

@login_required  
def criterio(request):
    storage =messages.get_messages(request)
    usuario=get_user(request)
    resultado= 0.0
    #evaluado=Expertos.objects.get(pk=usuario.id)
    conf=Eval_Conf.objects.latest('id')

    if request.method == 'GET':
        formset = BookFormset()
        print("hoal")
        #text = open(os.path.join(settings.MEDIA_DIR, 'name.csv'), 'rb').read()
        #file_path = os.path.join(settings.BASE_DIR, 'media', 'name.csv')
        #with open(file_path, 'r') as f:
         #   print("hola")
        return render(request, "criterio.html", {
        'formset': formset,'message':storage,
    
    })
    elif request.method == 'POST':
        formset = BookFormset(request.POST)
        if formset.is_valid():
            print("asdasd")

            conf=Eval_Conf.objects.latest('id')    

            print(conf.evaluado.all())

            for b in conf.evaluador.all():
                evaluador=get_object_or_404(Evaluadores,id=b.id)
                print("asas",b.Nombre)
                for a in conf.evaluado.all():
                    evaluado=get_object_or_404(Evaluados,id=a.id)
                 #   evaluacion=Eval_Data.objects.create(Nombre="conf",conf=conf,Evaluado=evaluado,Evaluador=evaluador)
            for form in formset:
                
                # extract name from each form and save
                name = form.cleaned_data.get('Nombre')
                peso= form.cleaned_data.get('peso')
                #resultado=resultado+peso
                if name :

                    Collection(Nombre=name,Peso=peso,Conf=conf).save()
                    resultado=resultado+float(peso)
                    print("el result es",float(resultado))
                    
            if float(resultado)!=1:
                Collection.objects.filter(Conf=conf).delete()
                messages.success(request,"Error en el criterio")
                return render(request, "criterio.html", {
        'formset': formset,'message':storage,
          
    })

            messages.success(request,"Criterios creados exitosamente")
              # save book instance
            return HttpResponseRedirect(reverse('registro:evaluacion'))   
        
        else:
            return render(request, "criterio.html", {
        'formset': formset,'message':storage,
          
    })
            # if name :
                    
                  #  conf=Eval_Conf.objects.latest('id')
                   # criterio=Collection.objects.filter(Conf=conf)
                  #  for c in criterio:
                   #     resultado=resultado+float(c.Peso)
                   #     print("iterando",resultado)
                   # print("result es ",resultado)
                  #  if(resultado<1):
                      #  Collection(Nombre=name,Peso=peso,Conf=conf).save()
                    #Periodos(Peso=name,conf=conf).save()

            # once all books are saved, redirect to book list view
           # return HttpResponseRedirect(reverse('registro:collection_create'))
            return HttpResponseRedirect(reverse('registro:evaluacion'))
   
    return render(request, "criterio.html", {
        'formset': formset,'message':storage,
    
    })



@login_required  
#mis evaluaciones pasadas
def mis_graficos(request):
        usuario = get_user(request)
        if usuario.groups.filter(name = 'admin').exists():
            conf=Eval_Conf.objects.all()
            conf2=Conf_Auto.objects.all()
        else:
            conf2=None
            try:
                evaluado=Evaluados.objects.get(pk=usuario.id)
                conf=Eval_Conf.objects.filter(evaluado=evaluado)

            except ObjectDoesNotExist:
                evaluado= None
                conf = None
      #  evaluado=evaluadorForm(request.POST) 
     #   for i in conf:
         #   file1 = open("myfile.txt","w")
         #   data=Eval_Data.objects.filter(conf=i)
          #  for k in data:
              #  file1.write("%s " % k.Peso1 )
       # file1.close()
        return render(request, 'mis_graficos.html', {'form':conf,'form2':conf2})



def chartauto(request,pk):
    usuario = get_user(request)
    cantidad=0
    if usuario.groups.filter(name = 'admin').exists():
        confi=Eval_Conf.objects.all()
        conf2=Conf_Auto.objects.all()
    conf = Eval_Conf.objects.get(pk=pk)
    crit=Collection.objects.filter(Conf=conf)
    try:
        etiquetas=CollectionTitle.objects.filter(collection=crit[0]) 
    except:
        etiquetas=None
        messages.success(request,"Etiquetas no configuradas")
        return render(request, 'mis_graficos.html', {'form':confi,'form2':conf2})
    for i in etiquetas:
        cantidad=cantidad+1
    print("la coleccion es ",cantidad)





    fds = sum([len(files) for r, d, files in os.walk(settings.MEDIA_DIR+'/datos/'+str(conf.Nombre)+'/')])
    print ("asdada",fds)


    if conf.tipo_periodo =="Ultima Semana":
        dataSource = {}
        dataSource['chart'] = {
                
                    "caption": "Mejor moneda por dia en los ultimos 7 días",
                    "subCaption" : "    ",
                    "xAxisName": "Evaluados",
                    "yAxisName": "Puntuacion",
                "theme": "zune"

                }

    elif conf.tipo_periodo =="Ultimos 15 días":
        dataSource = {}
        dataSource['chart'] = {
                
                    "caption": "Mejor moneda por dia en los ultimos 15 días",
                    "subCaption" : "    ",
                    "xAxisName": "Evaluados",
                    "yAxisName": "Puntuacion",
                "theme": "zune"

                }
    else:
        dataSource = {}
        dataSource['chart'] = {
                
                    "caption": "Mejor moneda por dia en los ultimos 30 días",
                    "subCaption" : "    ",
                    "xAxisName": "Evaluados",
                    "yAxisName": "Puntuacion",
                "theme": "zune"

                }
        # The data for the chart should be in an array where each element of the array is a JSON object
        # having the `label` and `value` as key value pair.

    dataSource['data'] = []
        # Iterate through the data in `Revenue` model and insert in to the `dataSource['data']` list.
        
    dws_f_obj=crypto.algo(fds,conf.tolerancia,conf.umbral,conf.Nombre)


    #plt.figure()
    #for i in range(linguistic_var_number):
    #    plt.plot(LV_time[4][atributo][i],[0,1,0])
    #plt.show()
    for t in dws_f_obj:
        data= {}
        datass = []
        if( dws_f_obj[t].index(max(dws_f_obj[t]))+1 ==1):
            data['label'] = crypto.criptomonedas[0]
        elif( dws_f_obj[t].index(max(dws_f_obj[t]))+1 ==2):
            data['label']= crypto.criptomonedas[1]
        elif( dws_f_obj[t].index(max(dws_f_obj[t]))+1 ==3):
            data['label'] = crypto.criptomonedas[2]

        elif( dws_f_obj[t].index(max(dws_f_obj[t]))+1 ==4):
            data['label'] = crypto.criptomonedas[3]     
        else:
            data['label']=  crypto.criptomonedas[4]      
        data['value'] =round(max(dws_f_obj[t])+1,2)
    
    
        dataSource['data'].append(data)
        if conf.tipo_periodo =="Ultima Semana":
            if t == 6:
                break
        elif conf.tipo_periodo =="Ultimos 15 días":
            if t == 14:
                break

        else:
            if t ==29:
                break


        #for i in range(1,cpt,1):
        # os.remove(str(settings.MEDIA_DIR)+'\datos\\'+str(i)+".csv")      
        # Create an object for the Column 2D chart using the FusionCharts class constructor
    column2D = FusionCharts("column2d", "ex1" , "900", "700", "chart-1", "json", dataSource)
    conf.img= os.path.join(settings.BASE_DIR,'books_read.png ')
    conf.save()

    return render(request, 'graf_auto.html', {'output': column2D.render(),})








def confediciion(request,pk):

    usuario = get_user(request) 

    #experto=get_object_or_404(id,id=usuario.id)
    post=Eval_Conf.objects.get(pk=pk)
 

    if request.method=='POST':

        form = confforma(request.POST,instance=post)


        if(form.is_valid() ):
           # form = FrutaForm(request.POST, instance=post)
            form.save()


        messages.success(request,"Evaluacion evaluada exitosamente")
        return HttpResponseRedirect(reverse('registro:hello_world', ))

    else:

        form=confforma(instance=post)

        context= {'form':form,'post':post}
        return render(request,'confediciion.html',{'form':form,})


def retry(request,pk):
    post=Eval_Conf.objects.get(pk=pk)
    if request.method=='POST':

        form = confauto(request.POST,instance=post)


        if(form.is_valid() ):
           # form = FrutaForm(request.POST, instance=post)
            form.save()


        messages.success(request,"Evaluacion evaluada exitosamente")
        return HttpResponseRedirect(reverse('registro:crear_eval', ))

    else:

        form=confauto(instance=post)

        context= {'form':form,'post':post}
        return render(request,'retry.html',{'form':form,})



def drift_list(request):
    post=Eval_Conf.objects.filter(modo="Automatico")
    if request.method=='POST':


        messages.success(request,"Evaluacion evaluada exitosamente")
        return HttpResponseRedirect(reverse('registro:crear_eval', ))

    else:

  

        
        return render(request,'drift_list.html',{'conf2':post,})




def etiqueta_auto(request,pk):
    post=Eval_Conf.objects.get(pk=pk)
    if request.method=='POST':


        messages.success(request,"Evaluacion evaluada exitosamente")
        return HttpResponseRedirect(reverse('registro:evaluacion', ))

    else:
        cuenta_lineas = 0
        etiquetas=[]
       # settings.MEDIA_DIR+'/datos/'+str(conf.Nombre)+'/'
        archivo = open(os.path.join(settings.MEDIA_DIR+'/datos/'+str(post.Nombre)+'/',""+str(1)+".csv"))
        for linea in archivo:
            linea = linea.replace(",","").replace("-","0")
            datos = linea.strip().split(";")

            if cuenta_lineas == 1:
                for n in datos:

                    etiquetas.append(n)
                    Collection(Nombre=n,Conf=post).save()

               # etiquetas[index]= datos[1]
                break 
            cuenta_lineas += 1
        archivo.close()
        print("intentando algo",n )
        crit=Collection.objects.filter(Conf=post)
        crit[0].delete()
        
        return render(request,'etiqueta_auto.html',{'conf2':etiquetas,})


def confmanual(request):

    usuario = get_user(request) 

    post=Eval_Conf.objects.last()
 

    if request.method=='POST':

        form = FrutaForm(request.POST)

        if form.is_valid() :
            asd=form.save(commit=False)
            asd.Nombre=post.Nombre
            asd.modo=post.modo
            asd.status="Creado"
            asd.tipo_periodo=post.tipo_periodo
            Eval_Conf.objects.filter(id=post.id).delete()
            form.save()
 
            asd.save()

                
            for b in asd.evaluador.all():
                evaluador=get_object_or_404(Evaluadores,id=b.id)
                print("asas",b.Nombre)
                for a in asd.evaluado.all():
                    evaluado=get_object_or_404(Evaluados,id=a.id)
                    evaluacion=Eval_Data.objects.create(Nombre="conf",conf=asd,Evaluado=evaluado,Evaluador=evaluador)

                    get_csv(asd.id,repeat=60) 
        else:
            messages.success(request,"Error en la creación de la evaluación")
            return render(request,'confediciion.html',{'form':form,})

        messages.success(request,"Evaluacion evaluada exitosamente")
        return HttpResponseRedirect(reverse('registro:criterio', ))

    else:

        form=FrutaForm()

        context= {'form':form,'post':post}
        return render(request,'confediciion.html',{'form':form,})

    
@login_required
def Atributos_tiempo(request):
    post=Eval_Conf.objects.filter(modo="Automatico")
    if request.method=='POST':


        messages.success(request,"Evaluacion evaluada exitosamente")
        return HttpResponseRedirect(reverse('registro:crear_eval', ))

    else:

  

        
        return render(request,'drift_list.html',{'conf2':post,})




@login_required    
def edit_etiqauto(request,pk):
    usuario=get_user(request)
    conf=Eval_Conf.objects.get(id=pk)
    crit=Collection.objects.filter(Conf=conf)
    print("El criterio 0 es ", crit[0])
    #primercrit=crit.objects.first()
    if request.method == 'GET':
        formset = BookFormset2()
        form2=decidirForm()
        form=FrutaForm2(instance=conf)
        
        context= {'form':crit,}
        return render(request,'edit_etiqauto.html', {'form':crit,'formset':formset})
        
    elif request.method == 'POST':
        formset = BookFormset2(request.POST)
        if formset.is_valid():
            conf.status="Activo"
            conf.save()
            for form in formset:
                
                # extract name from each form and save
                name = form.cleaned_data.get('Nombre')

                # save book instance
                if name:
                    conf=Eval_Conf.objects.latest('id')

                    CollectionTitle(Nombre=name,collection=crit[0]).save()
           # CollectionTitle()
       # messages.success(request,"etiquetas creadas correctamente")

        return HttpResponseRedirect(reverse('registro:evaluacion',))
     