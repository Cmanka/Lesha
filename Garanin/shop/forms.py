from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm

from shop.models import Category, Discount, Product, Order, Client
import re
from django.core.exceptions import ValidationError


class CategoryForm(forms.ModelForm):
    class Meta:
        model = Category
        fields = ['name', 'description']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control'}),
        }


class DiscountForm(forms.ModelForm):
    class Meta:
        model = Discount
        fields = ['name', 'description', 'price']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control'}),
            'price': forms.NumberInput(attrs={'class': 'form-control'}),
        }


class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = ['name', 'producer', 'category', 'image', 'price', 'discount', 'is_on_shop']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'producer': forms.Select(attrs={'class': 'form-control'}),
            'category': forms.Select(attrs={'class': 'form-control'}),
            'price': forms.NumberInput(attrs={'class': 'form-control'}),
            'discount': forms.Select(attrs={'class': 'form-control'}),
        }


class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = ['employee', 'product', 'client', 'date']
        widgets = {
            'employee': forms.Select(attrs={'class': 'form-control'}),
            'product': forms.Select(attrs={'class': 'form-control'}),
            'client': forms.Select(attrs={'class': 'form-control'}),
            'date': forms.DateInput(attrs={'class': 'form-control'}),
        }


class ClientForm(forms.ModelForm):
    class Meta:
        model = Client
        fields = ['last_name', 'first_name', 'middle_name', 'email', 'phone', 'address']
        widgets = {
            'last_name': forms.TextInput(attrs={'class': 'form-control'}),
            'first_name': forms.TextInput(attrs={'class': 'form-control'}),
            'middle_name': forms.TextInput(attrs={'class': 'form-control'}),
            'email': forms.EmailInput(attrs={'class': 'form-control'}),
            'phone': forms.TextInput(attrs={'class': 'form-control'}),
            'address': forms.TextInput(attrs={'class': 'form-control'}),
        }

    def clean_first_name(self):
        first_name = self.cleaned_data['first_name']
        if re.search('\d', first_name):
            raise ValidationError('Field cannot contain numbers in name')
        return first_name

    def clean_last_name(self):
        last_name = self.cleaned_data['last_name']
        if re.search('\d', last_name):
            raise ValidationError('Field cannot contain numbers in name')
        return last_name

    def clean_middle_name(self):
        middle_name = self.cleaned_data['middle_name']
        if re.search('\d', middle_name):
            raise ValidationError('Field cannot contain numbers in name')
        return middle_name


class EmployeesQueryForm(forms.Form):
    last_name = forms.ChoiceField()


class CategoryQueryForm(forms.Form):
    name = forms.ChoiceField()


class ProductQueryForm(forms.Form):
    more_price = forms.IntegerField()


class UserLoginForm(AuthenticationForm):
    username = forms.CharField(label='User name', widget=forms.TextInput(attrs={'class': 'form-control'}))
    password = forms.CharField(label='Password', widget=forms.PasswordInput(attrs={'class': 'form-control'}))
