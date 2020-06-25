# Generated by Django 2.2.5 on 2019-12-10 08:33

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('eval', '0017_auto_20191210_0434'),
    ]

    operations = [
        migrations.AddField(
            model_name='eval_conf',
            name='img',
            field=models.ImageField(blank=True, null=True, upload_to=''),
        ),
        migrations.AlterField(
            model_name='eval_conf',
            name='fecha',
            field=models.DateTimeField(default=datetime.datetime(2019, 12, 10, 8, 33, 34, 187144, tzinfo=utc), verbose_name='Date'),
        ),
        migrations.AlterField(
            model_name='eval_conf',
            name='tipo_automatico',
            field=models.CharField(max_length=50),
        ),
    ]
