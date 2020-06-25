from django.contrib import admin
from eval.models import *

admin.site.register(Evaluadores)
admin.site.register(Evaluados)
admin.site.register(Criterios)
admin.site.register(Etiquetas)
admin.site.register(Eval_Conf)
admin.site.register(Periodos)
admin.site.register(Eval_Data)
admin.site.register(Expertos)
admin.site.register(Resultados)
admin.site.register(UserProfileInfo)
admin.site.register(Collection)
admin.site.register(CollectionTitle)
admin.site.register(Conf_Auto)
def make_published(modeladmin, request, queryset):
    queryset.update(status='p')
make_published.short_description = "Mark selected stories as published"

class ArticleAdmin(admin.ModelAdmin):
    list_display = ['Nombre', 'Nombre']
    ordering = ['Nombre']
    actions = [make_published]
class DataAdmin(admin.ModelAdmin):
    list_display = ['Nombre', 'Criterio', 'Evaluado', 'Evaluador','Periodo']
    ordering = ['Evaluador']
    actions = [make_published]

