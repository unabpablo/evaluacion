# Generated by Django 2.2.5 on 2019-12-04 23:21

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('eval', '0008_auto_20191204_1403'),
    ]

    operations = [
        migrations.AddField(
            model_name='eval_conf',
            name='modo',
            field=models.CharField(blank=True, max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='eval_conf',
            name='fecha',
            field=models.DateTimeField(default=datetime.datetime(2019, 12, 4, 23, 21, 25, 61168, tzinfo=utc), verbose_name='Date'),
        ),
    ]
