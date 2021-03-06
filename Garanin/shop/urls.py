from django.urls import path

from .views import *

urlpatterns = [
    path('', IndexView.as_view(), name='home'),
    path('categories/', CategoriesView.as_view(), name='categories'),
    path('add_category/', CreateCategoryView.as_view(), name='add_category'),
    path('edit_category/<int:pk>', EditCategoryView.as_view(), name='edit_category'),
    path('delete_category/<int:pk>', DeleteCategoryView.as_view(), name='delete_category'),
    path('discounts/', DiscountsView.as_view(), name='discounts'),
    path('add_discount/', CreateDiscountView.as_view(), name='add_discount'),
    path('edit_discount/<int:pk>', EditDiscountView.as_view(), name='edit_discount'),
    path('delete_discount/<int:pk>', DeleteDiscountView.as_view(), name='delete_discount'),
    path('products/', ProductsView.as_view(), name='products'),
    path('add_product/', CreateProductView.as_view(), name='add_product'),
    path('edit_product/<int:pk>', EditProductView.as_view(), name='edit_product'),
    path('delete_product/<int:pk>', DeleteProductView.as_view(), name='delete_product'),
    path('orders/', OrdersView.as_view(), name='orders'),
    path('add_order/', CreateOrderView.as_view(), name='add_order'),
    path('edit_order/<int:pk>', EditOrderView.as_view(), name='edit_order'),
    path('delete_order/<int:pk>', DeleteOrderView.as_view(), name='delete_order'),
    path('clients/', ClientsView.as_view(), name='clients'),
    path('add_client/', CreateClientView.as_view(), name='add_client'),
    path('edit_client/<int:pk>', EditClientView.as_view(), name='edit_client'),
    path('delete_client/<int:pk>', DeleteClientView.as_view(), name='delete_client'),
    path('report/', ReportView.as_view(), name='report'),
    path('pdf/', GetPdf.as_view(), name='get_pdf'),
    path('queries/', QueriesIndexView.as_view(), name='queries'),
    path('query1/', get_count_managers, name='get_count_managers'),
    path('query2/', get_orders_by_employee, name='get_orders_by_employee'),
    path('query3/', get_products_by_category, name='get_products_by_category'),
    path('query4/', get_products_by_price, name='get_products_by_price'),
    path('login/', user_login, name='login'),
    path('logout/', user_logout, name='logout'),
]
