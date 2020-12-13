from django.contrib import admin
from .models import *


class PositionAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'salary')
    list_display_links = ('id', 'name', 'salary')


class EmployeeAdmin(admin.ModelAdmin):
    list_display = ('id', 'first_name', 'last_name', 'middle_name', 'email', 'phone', 'position')
    list_display_links = ('id', 'first_name', 'last_name', 'middle_name', 'email', 'phone', 'position')


class ClientAdmin(admin.ModelAdmin):
    list_display = ('id', 'first_name', 'last_name', 'middle_name', 'email', 'phone', 'address')
    list_display_links = ('id', 'first_name', 'last_name', 'middle_name', 'email', 'phone', 'address')


class ProducerAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'email', 'phone', 'address')
    list_display_links = ('id', 'name', 'email', 'phone', 'address')


class DiscountAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'description', 'price')
    list_display_links = ('id', 'name', 'description', 'price')


class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'description')
    list_display_links = ('id', 'name', 'description')


class ProductAdmin(admin.ModelAdmin):
    list_display = (
        'id', 'name', 'producer', 'category', 'price', 'discount', 'is_on_shop')
    list_display_links = (
        'id', 'name', 'producer', 'category', 'price', 'discount', 'is_on_shop')


class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'employee', 'product', 'client', 'date')
    list_display_links = ('id', 'employee', 'product', 'client', 'date')


admin.site.register(Position, PositionAdmin)
admin.site.register(Employee, EmployeeAdmin)
admin.site.register(Client, ClientAdmin)
admin.site.register(Producer, ProducerAdmin)
admin.site.register(Discount, DiscountAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(Product, ProductAdmin)
admin.site.register(Order, OrderAdmin)
