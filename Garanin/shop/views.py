from django.contrib.auth import login, logout
from django.db import connection
from django.forms import Form
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.urls import reverse_lazy
from django.views import View
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import *
from .mixins import *
from .forms import *
import datetime
from weasyprint import HTML
import tempfile
from django.template.loader import render_to_string

from .render import Render


class IndexView(ListView):
    queryset = object
    template_name = 'shop/index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Home page'
        context['models'] = {
            'Categories': ['categories', 'click and get full information'],
            'Discounts': ['discounts', 'click and get full information'],
            'Products': ['products', 'click and get full information'],
            'Orders': ['orders', 'click and get full information'],
            'Clients': ['clients', 'click and get full information']
        }
        return context


class CategoriesView(ListView):
    Model = Category
    context_object_name = 'categories'
    template_name = 'shop/categories/index.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Categories page'
        return context

    def get_queryset(self):
        return Category.objects.all()


class CreateCategoryView(CreateView):
    form_class = CategoryForm
    template_name = 'shop/categories/add.html'
    success_url = reverse_lazy('categories')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new category'
        return context


class EditCategoryView(UpdateView):
    model = Category
    form_class = CategoryForm
    template_name = 'shop/categories/edit.html'
    success_url = reverse_lazy('categories')


class DeleteCategoryView(DeleteView):
    model = Category
    template_name = 'shop/categories/delete.html'
    success_url = reverse_lazy('categories')


class DiscountsView(ListView):
    Model = Discount
    context_object_name = 'discounts'
    template_name = 'shop/discounts/index.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Discounts page'
        return context

    def get_queryset(self):
        return Discount.objects.all()


class CreateDiscountView(CreateView):
    form_class = DiscountForm
    template_name = 'shop/discounts/add.html'
    success_url = reverse_lazy('discounts')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new discount'
        return context


class EditDiscountView(UpdateView):
    model = Discount
    form_class = DiscountForm
    template_name = 'shop/discounts/edit.html'
    success_url = reverse_lazy('discounts')


class DeleteDiscountView(DeleteView):
    model = Discount
    template_name = 'shop/discounts/delete.html'
    success_url = reverse_lazy('discounts')


class ProductsView(ListView):
    Model = Product
    context_object_name = 'products'
    template_name = 'shop/products/index.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Products page'
        return context

    def get_queryset(self):
        return Product.objects.all()


class CreateProductView(CreateView):
    form_class = ProductForm
    template_name = 'shop/products/add.html'
    success_url = reverse_lazy('products')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new product'
        return context


class EditProductView(UpdateView):
    model = Product
    form_class = ProductForm
    template_name = 'shop/products/edit.html'
    success_url = reverse_lazy('products')


class DeleteProductView(DeleteView):
    model = Product
    template_name = 'shop/products/delete.html'
    success_url = reverse_lazy('products')


class OrdersView(ListView):
    Model = Order
    context_object_name = 'orders'
    template_name = 'shop/orders/index.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Orders page'
        return context

    def get_queryset(self):
        return Order.objects.all()


class CreateOrderView(CreateView):
    form_class = OrderForm
    template_name = 'shop/orders/add.html'
    success_url = reverse_lazy('orders')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new order'
        return context


class EditOrderView(UpdateView):
    model = Order
    form_class = OrderForm
    template_name = 'shop/orders/edit.html'
    success_url = reverse_lazy('orders')


class DeleteOrderView(DeleteView):
    model = Order
    template_name = 'shop/orders/delete.html'
    success_url = reverse_lazy('orders')


class ClientsView(ListView):
    Model = Client
    context_object_name = 'clients'
    template_name = 'shop/clients/index.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Clients page'
        return context

    def get_queryset(self):
        return Client.objects.all()


class CreateClientView(CreateView):
    form_class = ClientForm
    template_name = 'shop/clients/add.html'
    success_url = reverse_lazy('clients')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new client'
        return context


class EditClientView(UpdateView):
    model = Client
    form_class = ClientForm
    template_name = 'shop/clients/edit.html'
    success_url = reverse_lazy('clients')


class DeleteClientView(DeleteView):
    model = Client
    template_name = 'shop/clients/delete.html'
    success_url = reverse_lazy('clients')


class ReportView(ListView):
    Model = Employee
    context_object_name = 'employees'
    template_name = 'shop/report/index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Report page'
        return context

    def get_queryset(self):
        return Employee.objects.all()


class GetPdf(View):

    def get(self, request):
        employees = Employee.objects.all()
        params = {
            'employees': employees,
            'request': request,
        }
        return Render.render('shop/report/pdf-output.html', params)


class QueriesIndexView(ListView):
    queryset = object
    template_name = 'shop/queries/index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Queries page'
        context['queries'] = {
            'Get count of the managers': 'get_count_managers',
            'Get orders by employee': 'get_orders_by_employee',
            'Get products by category': 'get_products_by_category',
            'Get products by price': 'get_products_by_price',
        }
        return context


def get_count_managers(request):
    if request.method == 'POST':
        with connection.cursor() as c:
            c.callproc('get_count_managers', )
            result = c.fetchall()
        context = {'result': result, 'title': 'Query result'}
        return render(request, 'shop/queries/get_count_managers/result.html', context)
    else:
        query_form = Form()
        context = {'form': query_form, 'title': 'Get count of the managers'}
        return render(request, 'shop/queries/get_count_managers/query.html', context)


def get_orders_by_employee(request):
    if request.method == 'POST':
        name = request.POST.get("last_name")
        with connection.cursor() as c:
            c.callproc('get_order_by_employee', [name])
            result = c.fetchall()
        context = {'results': result, 'title': 'Query result'}
        return render(request, 'shop/queries/get_orders_by_employee/result.html', context)
    else:
        query_form = EmployeesQueryForm()
        employees = Employee.objects.all()
        query_form.fields['last_name'].choices = [(employee.last_name, employee.last_name) for employee in employees]
        context = {'form': query_form, 'title': 'Get orders by employee'}
        return render(request, 'shop/queries/get_orders_by_employee/query.html', context)


def get_products_by_category(request):
    if request.method == 'POST':
        name = request.POST.get("name")
        with connection.cursor() as c:
            c.callproc('get_product_by_category', [name])
            result = c.fetchall()
        context = {'results': result, 'title': 'Query result'}
        return render(request, 'shop/queries/get_products_by_category/result.html', context)
    else:
        query_form = CategoryQueryForm()
        categories = Category.objects.all()
        query_form.fields['name'].choices = [(category.name, category.name) for category in categories]
        context = {'form': query_form, 'title': 'Get products by category'}
        return render(request, 'shop/queries/get_products_by_category/query.html', context)


def get_products_by_price(request):
    if request.method == 'POST':
        price = request.POST.get("more_price")
        with connection.cursor() as c:
            c.callproc('get_products_by_price', [price])
            results = c.fetchall()
        context = {'results': results, 'title': 'Query result'}
        return render(request, 'shop/queries/get_products_by_price/result.html', context)
    else:
        query_form = ProductQueryForm()
        context = {'form': query_form, 'title': 'Get products by price'}
        return render(request, 'shop/queries/get_products_by_price/query.html', context)


def user_login(request):
    if request.method == 'POST':
        form = UserLoginForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('home')
    else:
        form = UserLoginForm()
    return render(request, 'shop/authorization/login.html', {'form': form})


def user_logout(request):
    logout(request)
    return redirect('login')
