from django.urls import path
from .views import SumView

urlpatterns = [
    path('sum/', SumView.as_view(), name='sum'),
]
