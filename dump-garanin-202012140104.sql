PGDMP                         x            garanin    12.5    12.5 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    35333    garanin    DATABASE     y   CREATE DATABASE garanin WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';
    DROP DATABASE garanin;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1255    35656    add_values()    FUNCTION       CREATE FUNCTION public.add_values() RETURNS void
    LANGUAGE sql
    AS $$
	insert into public.shop_category (id,"name",description)
	values
	(1,'category1','desc1'),
	(2,'category2','desc2'),
	(3,'category3','desc3'),
	(4,'category4','desc4');
	insert into public.shop_client (id,first_name,last_name,middle_name,email,phone,address)
	values
	(1,'Pakhom','Menshikov','Samsonovich','example1@gmail.com','+375333415378','address1'),
	(2,'Pakhom','Zakryatin','Nikanorovich','example2@gmail.com','+375333515378','address2'),
	(3,'Agap','Shein','Nikiforovich','example3@gmail.com','+375333615378','address3'),
	(4,'Vladlen','Mikhalitsyn','Samuilovich','example4@gmail.com','+375333715378','address4'),
	(5,'Varvara','Selezneva','Georgievna','example5@gmail.com','+375333225378','address5');
	insert into public.shop_position (id,"name",salary)
	values
	(1,'employee',100),
	(2,'manager',200);
	insert into public.shop_employee (id,first_name,last_name,middle_name,email,phone,position_id)
	values
	(2,'Agata','Domasha','Ippolitovna','example8@gmail.com','+375333221378',1),
	(3,'Zoya','Rodionova','Mikheevna','example9@gmail.com','+375333217778',1),
	(4,'Ksenia','Tabernakulova','Yulievna','example10@gmail.com','+375333211318',2),
	(5,'Terenty','Kotyash','Nikanorovich','example11@gmail.com','+375333245338',1),
	(6,'Margarita','Bandurkina','Timurovna','example12@gmail.com','+375333225379',1),
	(7,'Matvey','Sechenov','Onisimovich','example13@gmail.com','+375333216373',1);
	insert into public.shop_producer (id,"name",email,phone,address)
	values
	(1,'provider1','email123@gmail.com','+375339540312','address10'),
	(2,'provider2','email124@gmail.com','+375339541312','address11');
	insert into public.shop_discount (id,"name",description,price)
	values
	(1,'discount1','desc1',100),
	(2,'discount2','desc2',200),
	(3,'discount3','desc3',300),
	(4,'discount4','desc4',400);
	insert into public.shop_product (id,"name",price,is_on_shop,category_id,discount_id,producer_id)
	values
	(1,'product1',15000,true,1,2,1),
	(2,'product2',12000,true,2,1,2),
	(3,'product3',6000,false,4,3,1),
	(4,'product4',4000,true,3,4,1),
	(5,'product5',20000,false,2,2,2),
	(6,'product6',8000,true,1,1,1),
	(7,'product7',10000,false,3,4,1),
	(8,'product8',5000,true,4,4,2),
	(9,'product9',3500,true,1,3,2),
	(10,'product10',8000,true,2,3,1);
	insert into public.shop_order (id,client_id,employee_id,product_id,"date")
	values
	(1,1,2,1,TO_DATE('12/11/2020', 'DD/MM/YYYY')),
	(2,2,3,2,TO_DATE('13/11/2020', 'DD/MM/YYYY')),
	(3,3,5,3,TO_DATE('14/11/2020', 'DD/MM/YYYY')),
	(4,4,6,4,TO_DATE('15/11/2020', 'DD/MM/YYYY')),
	(5,5,7,5,TO_DATE('16/11/2020', 'DD/MM/YYYY')),
	(6,2,2,1,TO_DATE('17/11/2020', 'DD/MM/YYYY')),
	(7,2,7,1,TO_DATE('18/11/2020', 'DD/MM/YYYY')),
	(8,3,6,8,TO_DATE('19/11/2020', 'DD/MM/YYYY')),
	(9,1,2,7,TO_DATE('20/11/2020', 'DD/MM/YYYY'));
$$;
 #   DROP FUNCTION public.add_values();
       public          postgres    false    3            �            1255    35655    delete_values()    FUNCTION     e  CREATE FUNCTION public.delete_values() RETURNS void
    LANGUAGE sql
    AS $$
	delete from public.shop_category;
	delete from public.shop_client;
	delete from public.shop_position;
	delete from public.shop_employee;
	delete from public.shop_producer;
	delete from public.shop_discount;
	delete from public.shop_product;
	delete from public.shop_order;
$$;
 &   DROP FUNCTION public.delete_values();
       public          postgres    false    3            �            1255    35667    get_count_managers()    FUNCTION     �   CREATE FUNCTION public.get_count_managers() RETURNS bigint
    LANGUAGE sql
    AS $$
	select count(*)
	from shop_employee se
	join shop_position sp on se.position_id = sp.id 
	where sp.name = 'manager';
$$;
 +   DROP FUNCTION public.get_count_managers();
       public          postgres    false    3                       1255    35670 (   get_order_by_employee(character varying)    FUNCTION       CREATE FUNCTION public.get_order_by_employee(employee_last_name character varying) RETURNS TABLE(client_last_name character varying, client_first_name character varying, product_name character varying, order_date date)
    LANGUAGE sql
    AS $$
	select sc.last_name, sc.first_name, sp."name" , so."date" 
	from shop_order so 
	join shop_client sc 
	on sc.id = so.client_id 
	join shop_product sp 
	on sp.id = so.product_id 
	join shop_employee se 
	on se.id = so.employee_id 
	where se.last_name = employee_last_name;
$$;
 R   DROP FUNCTION public.get_order_by_employee(employee_last_name character varying);
       public          postgres    false    3                       1255    35669 *   get_product_by_category(character varying)    FUNCTION       CREATE FUNCTION public.get_product_by_category(category_name character varying) RETURNS TABLE(product_name character varying)
    LANGUAGE sql
    AS $$
	select sp."name" 
	from shop_product sp 
	join shop_category sc on sp.category_id = sc.id 
	where sc."name" = category_name;
$$;
 O   DROP FUNCTION public.get_product_by_category(category_name character varying);
       public          postgres    false    3                        1255    35668    get_products_by_price(integer)    FUNCTION     �   CREATE FUNCTION public.get_products_by_price(price_m integer) RETURNS TABLE(product_name character varying)
    LANGUAGE sql
    AS $$
	select sp."name" 
	from shop_product sp
	where sp.price >= price_m;
$$;
 =   DROP FUNCTION public.get_products_by_price(price_m integer);
       public          postgres    false    3            �            1255    35657    trigger_add_employee()    FUNCTION     �  CREATE FUNCTION public.trigger_add_employee() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare 
			employee_user_name varchar;
			employee_password varchar;
			employee_first_name varchar;
			employee_last_name varchar;
			employee_email varchar;
			employee_is_staff bool;
			employee_is_active bool;
	BEGIN
		employee_user_name = ('employee' || new.id);
		employee_password = ('AccPass_' || new.id || '*');
		employee_first_name = new.first_name;
		employee_last_name = new.last_name;
		employee_email = new.email;
		employee_is_active = true;
		employee_is_staff = true;
		insert into auth_user (id,username,"password",first_name,last_name,email,is_staff,is_active,is_superuser,date_joined)
		values
		(new.id,employee_user_name,md5(employee_password),employee_first_name,
		employee_last_name,employee_email,employee_is_staff,employee_is_active,false,now());
		insert into auth_user_groups(user_id,group_id)
		values
		(new.id,new.position_id);
	return null;
	END;
$$;
 -   DROP FUNCTION public.trigger_add_employee();
       public          postgres    false    3            �            1255    35659    trigger_check_discount_price()    FUNCTION     �   CREATE FUNCTION public.trigger_check_discount_price() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
	if new.price <= 0 then 
		raise exception 'Cannot add or update price less or equal 0';
	else
		return new;
	end if;
	END;
$$;
 5   DROP FUNCTION public.trigger_check_discount_price();
       public          postgres    false    3            �            1255    35658    trigger_delete_employee()    FUNCTION       CREATE FUNCTION public.trigger_delete_employee() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		delete from auth_user_groups aug
			where aug.user_id = old.id;
			delete from auth_user
			where username = ('employee' || old.id);
		return null;
	END;
$$;
 0   DROP FUNCTION public.trigger_delete_employee();
       public          postgres    false    3            �            1255    35662    trigger_for_product()    FUNCTION     v  CREATE FUNCTION public.trigger_for_product() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
	if new.price <= 0 then 
		raise exception 'Cannot add or update price less or equal 0';
	elsif (select price from shop_discount sd where sd.id = new.id) > new.price then
		raise exception 'Discount price cannot be more product price';
	else
		return new;
	end if;
	END;
$$;
 ,   DROP FUNCTION public.trigger_for_product();
       public          postgres    false    3            �            1259    35365 
   auth_group    TABLE     f   CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);
    DROP TABLE public.auth_group;
       public         heap    postgres    false    3            �            1259    35363    auth_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public          postgres    false    209    3            �           0    0    auth_group_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;
          public          postgres    false    208            �            1259    35375    auth_group_permissions    TABLE     �   CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         heap    postgres    false    3            �            1259    35373    auth_group_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public          postgres    false    211    3            �           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;
          public          postgres    false    210            �            1259    35357    auth_permission    TABLE     �   CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         heap    postgres    false    3            �            1259    35355    auth_permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public          postgres    false    3    207            �           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;
          public          postgres    false    206            �            1259    35383 	   auth_user    TABLE     �  CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);
    DROP TABLE public.auth_user;
       public         heap    postgres    false    3            �            1259    35393    auth_user_groups    TABLE        CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);
 $   DROP TABLE public.auth_user_groups;
       public         heap    postgres    false    3            �            1259    35391    auth_user_groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.auth_user_groups_id_seq;
       public          postgres    false    215    3            �           0    0    auth_user_groups_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;
          public          postgres    false    214            �            1259    35381    auth_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.auth_user_id_seq;
       public          postgres    false    213    3            �           0    0    auth_user_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;
          public          postgres    false    212            �            1259    35401    auth_user_user_permissions    TABLE     �   CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);
 .   DROP TABLE public.auth_user_user_permissions;
       public         heap    postgres    false    3            �            1259    35399 !   auth_user_user_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.auth_user_user_permissions_id_seq;
       public          postgres    false    217    3            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;
          public          postgres    false    216            �            1259    35461    django_admin_log    TABLE     �  CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);
 $   DROP TABLE public.django_admin_log;
       public         heap    postgres    false    3            �            1259    35459    django_admin_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public          postgres    false    219    3            �           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;
          public          postgres    false    218            �            1259    35347    django_content_type    TABLE     �   CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         heap    postgres    false    3            �            1259    35345    django_content_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public          postgres    false    3    205            �           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;
          public          postgres    false    204            �            1259    35336    django_migrations    TABLE     �   CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         heap    postgres    false    3            �            1259    35334    django_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public          postgres    false    203    3            �           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;
          public          postgres    false    202            �            1259    35492    django_session    TABLE     �   CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         heap    postgres    false    3            �            1259    35504    shop_category    TABLE     �   CREATE TABLE public.shop_category (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL
);
 !   DROP TABLE public.shop_category;
       public         heap    postgres    false    3            �            1259    35502    shop_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_category_id_seq;
       public          postgres    false    222    3            �           0    0    shop_category_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_category_id_seq OWNED BY public.shop_category.id;
          public          postgres    false    221            �            1259    35517    shop_client    TABLE     L  CREATE TABLE public.shop_client (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    middle_name character varying(50) NOT NULL,
    email character varying(80) NOT NULL,
    phone character varying(128) NOT NULL,
    address character varying(100) NOT NULL
);
    DROP TABLE public.shop_client;
       public         heap    postgres    false    3            �            1259    35515    shop_client_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.shop_client_id_seq;
       public          postgres    false    224    3            �           0    0    shop_client_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.shop_client_id_seq OWNED BY public.shop_client.id;
          public          postgres    false    223            �            1259    35531    shop_discount    TABLE     �   CREATE TABLE public.shop_discount (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    price numeric(9,2) NOT NULL
);
 !   DROP TABLE public.shop_discount;
       public         heap    postgres    false    3            �            1259    35529    shop_discount_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_discount_id_seq;
       public          postgres    false    3    226            �           0    0    shop_discount_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_discount_id_seq OWNED BY public.shop_discount.id;
          public          postgres    false    225            �            1259    35544    shop_employee    TABLE     C  CREATE TABLE public.shop_employee (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    middle_name character varying(50) NOT NULL,
    email character varying(80) NOT NULL,
    phone character varying(128) NOT NULL,
    position_id integer NOT NULL
);
 !   DROP TABLE public.shop_employee;
       public         heap    postgres    false    3            �            1259    35542    shop_employee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_employee_id_seq;
       public          postgres    false    3    228            �           0    0    shop_employee_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_employee_id_seq OWNED BY public.shop_employee.id;
          public          postgres    false    227            �            1259    35592 
   shop_order    TABLE     �   CREATE TABLE public.shop_order (
    id integer NOT NULL,
    date date NOT NULL,
    client_id integer NOT NULL,
    employee_id integer NOT NULL,
    product_id integer NOT NULL
);
    DROP TABLE public.shop_order;
       public         heap    postgres    false    3            �            1259    35590    shop_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.shop_order_id_seq;
       public          postgres    false    236    3            �           0    0    shop_order_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.shop_order_id_seq OWNED BY public.shop_order.id;
          public          postgres    false    235            �            1259    35556    shop_position    TABLE     �   CREATE TABLE public.shop_position (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    salary numeric(9,2) NOT NULL
);
 !   DROP TABLE public.shop_position;
       public         heap    postgres    false    3            �            1259    35554    shop_position_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_position_id_seq;
       public          postgres    false    3    230            �           0    0    shop_position_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_position_id_seq OWNED BY public.shop_position.id;
          public          postgres    false    229            �            1259    35566    shop_producer    TABLE     �   CREATE TABLE public.shop_producer (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(80) NOT NULL,
    phone character varying(128) NOT NULL,
    address character varying(100) NOT NULL
);
 !   DROP TABLE public.shop_producer;
       public         heap    postgres    false    3            �            1259    35564    shop_producer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_producer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_producer_id_seq;
       public          postgres    false    232    3            �           0    0    shop_producer_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_producer_id_seq OWNED BY public.shop_producer.id;
          public          postgres    false    231            �            1259    35582    shop_product    TABLE     2  CREATE TABLE public.shop_product (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    image character varying(100),
    price numeric(9,2) NOT NULL,
    is_on_shop boolean NOT NULL,
    category_id integer NOT NULL,
    discount_id integer NOT NULL,
    producer_id integer NOT NULL
);
     DROP TABLE public.shop_product;
       public         heap    postgres    false    3            �            1259    35580    shop_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.shop_product_id_seq;
       public          postgres    false    234    3            �           0    0    shop_product_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.shop_product_id_seq OWNED BY public.shop_product.id;
          public          postgres    false    233            �           2604    35368    auth_group id    DEFAULT     n   ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            �           2604    35378    auth_group_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            �           2604    35360    auth_permission id    DEFAULT     x   ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            �           2604    35386    auth_user id    DEFAULT     l   ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);
 ;   ALTER TABLE public.auth_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213            �           2604    35396    auth_user_groups id    DEFAULT     z   ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);
 B   ALTER TABLE public.auth_user_groups ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    35404    auth_user_user_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);
 L   ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    35464    django_admin_log id    DEFAULT     z   ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219                       2604    35350    django_content_type id    DEFAULT     �   ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    205    205            ~           2604    35339    django_migrations id    DEFAULT     |   ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203            �           2604    35507    shop_category id    DEFAULT     t   ALTER TABLE ONLY public.shop_category ALTER COLUMN id SET DEFAULT nextval('public.shop_category_id_seq'::regclass);
 ?   ALTER TABLE public.shop_category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    35520    shop_client id    DEFAULT     p   ALTER TABLE ONLY public.shop_client ALTER COLUMN id SET DEFAULT nextval('public.shop_client_id_seq'::regclass);
 =   ALTER TABLE public.shop_client ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    35534    shop_discount id    DEFAULT     t   ALTER TABLE ONLY public.shop_discount ALTER COLUMN id SET DEFAULT nextval('public.shop_discount_id_seq'::regclass);
 ?   ALTER TABLE public.shop_discount ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    35547    shop_employee id    DEFAULT     t   ALTER TABLE ONLY public.shop_employee ALTER COLUMN id SET DEFAULT nextval('public.shop_employee_id_seq'::regclass);
 ?   ALTER TABLE public.shop_employee ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    35595    shop_order id    DEFAULT     n   ALTER TABLE ONLY public.shop_order ALTER COLUMN id SET DEFAULT nextval('public.shop_order_id_seq'::regclass);
 <   ALTER TABLE public.shop_order ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    235    236            �           2604    35559    shop_position id    DEFAULT     t   ALTER TABLE ONLY public.shop_position ALTER COLUMN id SET DEFAULT nextval('public.shop_position_id_seq'::regclass);
 ?   ALTER TABLE public.shop_position ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    35569    shop_producer id    DEFAULT     t   ALTER TABLE ONLY public.shop_producer ALTER COLUMN id SET DEFAULT nextval('public.shop_producer_id_seq'::regclass);
 ?   ALTER TABLE public.shop_producer ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    35585    shop_product id    DEFAULT     r   ALTER TABLE ONLY public.shop_product ALTER COLUMN id SET DEFAULT nextval('public.shop_product_id_seq'::regclass);
 >   ALTER TABLE public.shop_product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233    234            �          0    35365 
   auth_group 
   TABLE DATA                 public          postgres    false    209            �          0    35375    auth_group_permissions 
   TABLE DATA                 public          postgres    false    211            �          0    35357    auth_permission 
   TABLE DATA                 public          postgres    false    207            �          0    35383 	   auth_user 
   TABLE DATA                 public          postgres    false    213            �          0    35393    auth_user_groups 
   TABLE DATA                 public          postgres    false    215            �          0    35401    auth_user_user_permissions 
   TABLE DATA                 public          postgres    false    217            �          0    35461    django_admin_log 
   TABLE DATA                 public          postgres    false    219            �          0    35347    django_content_type 
   TABLE DATA                 public          postgres    false    205            �          0    35336    django_migrations 
   TABLE DATA                 public          postgres    false    203            �          0    35492    django_session 
   TABLE DATA                 public          postgres    false    220            �          0    35504    shop_category 
   TABLE DATA                 public          postgres    false    222            �          0    35517    shop_client 
   TABLE DATA                 public          postgres    false    224            �          0    35531    shop_discount 
   TABLE DATA                 public          postgres    false    226            �          0    35544    shop_employee 
   TABLE DATA                 public          postgres    false    228            �          0    35592 
   shop_order 
   TABLE DATA                 public          postgres    false    236            �          0    35556    shop_position 
   TABLE DATA                 public          postgres    false    230            �          0    35566    shop_producer 
   TABLE DATA                 public          postgres    false    232            �          0    35582    shop_product 
   TABLE DATA                 public          postgres    false    234            �           0    0    auth_group_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);
          public          postgres    false    208            �           0    0    auth_group_permissions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 52, true);
          public          postgres    false    210            �           0    0    auth_permission_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);
          public          postgres    false    206            �           0    0    auth_user_groups_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 18, true);
          public          postgres    false    214            �           0    0    auth_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);
          public          postgres    false    212            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);
          public          postgres    false    216            �           0    0    django_admin_log_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.django_admin_log_id_seq', 17, true);
          public          postgres    false    218            �           0    0    django_content_type_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);
          public          postgres    false    204            �           0    0    django_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.django_migrations_id_seq', 19, true);
          public          postgres    false    202            �           0    0    shop_category_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_category_id_seq', 8, true);
          public          postgres    false    221            �           0    0    shop_client_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.shop_client_id_seq', 3, true);
          public          postgres    false    223            �           0    0    shop_discount_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_discount_id_seq', 5, true);
          public          postgres    false    225            �           0    0    shop_employee_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_employee_id_seq', 2, true);
          public          postgres    false    227            �           0    0    shop_order_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.shop_order_id_seq', 2, true);
          public          postgres    false    235            �           0    0    shop_position_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_position_id_seq', 1, true);
          public          postgres    false    229            �           0    0    shop_producer_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_producer_id_seq', 3, true);
          public          postgres    false    231            �           0    0    shop_product_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_product_id_seq', 11, true);
          public          postgres    false    233            �           2606    35490    auth_group auth_group_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public            postgres    false    209            �           2606    35417 R   auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 |   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
       public            postgres    false    211    211            �           2606    35380 2   auth_group_permissions auth_group_permissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public            postgres    false    211            �           2606    35370    auth_group auth_group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public            postgres    false    209            �           2606    35408 F   auth_permission auth_permission_content_type_id_codename_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);
 p   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
       public            postgres    false    207    207            �           2606    35362 $   auth_permission auth_permission_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public            postgres    false    207            �           2606    35398 &   auth_user_groups auth_user_groups_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
       public            postgres    false    215            �           2606    35432 @   auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);
 j   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
       public            postgres    false    215    215            �           2606    35388    auth_user auth_user_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
       public            postgres    false    213            �           2606    35406 :   auth_user_user_permissions auth_user_user_permissions_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
       public            postgres    false    217            �           2606    35446 Y   auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
       public            postgres    false    217    217            �           2606    35484     auth_user auth_user_username_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
       public            postgres    false    213            �           2606    35470 &   django_admin_log django_admin_log_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public            postgres    false    219            �           2606    35354 E   django_content_type django_content_type_app_label_model_76bd3d3b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);
 o   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
       public            postgres    false    205    205            �           2606    35352 ,   django_content_type django_content_type_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public            postgres    false    205            �           2606    35344 (   django_migrations django_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public            postgres    false    203            �           2606    35499 "   django_session django_session_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public            postgres    false    220            �           2606    35514 $   shop_category shop_category_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shop_category
    ADD CONSTRAINT shop_category_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.shop_category DROP CONSTRAINT shop_category_name_key;
       public            postgres    false    222            �           2606    35512     shop_category shop_category_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_category
    ADD CONSTRAINT shop_category_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_category DROP CONSTRAINT shop_category_pkey;
       public            postgres    false    222            �           2606    35528 #   shop_client shop_client_address_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_client
    ADD CONSTRAINT shop_client_address_key UNIQUE (address);
 M   ALTER TABLE ONLY public.shop_client DROP CONSTRAINT shop_client_address_key;
       public            postgres    false    224            �           2606    35524 !   shop_client shop_client_email_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.shop_client
    ADD CONSTRAINT shop_client_email_key UNIQUE (email);
 K   ALTER TABLE ONLY public.shop_client DROP CONSTRAINT shop_client_email_key;
       public            postgres    false    224            �           2606    35526 !   shop_client shop_client_phone_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.shop_client
    ADD CONSTRAINT shop_client_phone_key UNIQUE (phone);
 K   ALTER TABLE ONLY public.shop_client DROP CONSTRAINT shop_client_phone_key;
       public            postgres    false    224            �           2606    35522    shop_client shop_client_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.shop_client
    ADD CONSTRAINT shop_client_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.shop_client DROP CONSTRAINT shop_client_pkey;
       public            postgres    false    224            �           2606    35541 $   shop_discount shop_discount_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shop_discount
    ADD CONSTRAINT shop_discount_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.shop_discount DROP CONSTRAINT shop_discount_name_key;
       public            postgres    false    226            �           2606    35539     shop_discount shop_discount_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_discount
    ADD CONSTRAINT shop_discount_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_discount DROP CONSTRAINT shop_discount_pkey;
       public            postgres    false    226            �           2606    35551 %   shop_employee shop_employee_email_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_employee
    ADD CONSTRAINT shop_employee_email_key UNIQUE (email);
 O   ALTER TABLE ONLY public.shop_employee DROP CONSTRAINT shop_employee_email_key;
       public            postgres    false    228            �           2606    35553 %   shop_employee shop_employee_phone_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_employee
    ADD CONSTRAINT shop_employee_phone_key UNIQUE (phone);
 O   ALTER TABLE ONLY public.shop_employee DROP CONSTRAINT shop_employee_phone_key;
       public            postgres    false    228            �           2606    35549     shop_employee shop_employee_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_employee
    ADD CONSTRAINT shop_employee_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_employee DROP CONSTRAINT shop_employee_pkey;
       public            postgres    false    228            �           2606    35597    shop_order shop_order_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.shop_order DROP CONSTRAINT shop_order_pkey;
       public            postgres    false    236            �           2606    35563 $   shop_position shop_position_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shop_position
    ADD CONSTRAINT shop_position_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.shop_position DROP CONSTRAINT shop_position_name_key;
       public            postgres    false    230            �           2606    35561     shop_position shop_position_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_position
    ADD CONSTRAINT shop_position_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_position DROP CONSTRAINT shop_position_pkey;
       public            postgres    false    230            �           2606    35579 '   shop_producer shop_producer_address_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.shop_producer
    ADD CONSTRAINT shop_producer_address_key UNIQUE (address);
 Q   ALTER TABLE ONLY public.shop_producer DROP CONSTRAINT shop_producer_address_key;
       public            postgres    false    232            �           2606    35575 %   shop_producer shop_producer_email_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_producer
    ADD CONSTRAINT shop_producer_email_key UNIQUE (email);
 O   ALTER TABLE ONLY public.shop_producer DROP CONSTRAINT shop_producer_email_key;
       public            postgres    false    232            �           2606    35573 $   shop_producer shop_producer_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shop_producer
    ADD CONSTRAINT shop_producer_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.shop_producer DROP CONSTRAINT shop_producer_name_key;
       public            postgres    false    232            �           2606    35577 %   shop_producer shop_producer_phone_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_producer
    ADD CONSTRAINT shop_producer_phone_key UNIQUE (phone);
 O   ALTER TABLE ONLY public.shop_producer DROP CONSTRAINT shop_producer_phone_key;
       public            postgres    false    232            �           2606    35571     shop_producer shop_producer_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_producer
    ADD CONSTRAINT shop_producer_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_producer DROP CONSTRAINT shop_producer_pkey;
       public            postgres    false    232            �           2606    35589 "   shop_product shop_product_name_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_name_key UNIQUE (name);
 L   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_name_key;
       public            postgres    false    234            �           2606    35587    shop_product shop_product_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_pkey;
       public            postgres    false    234            �           1259    35491    auth_group_name_a6ea08ec_like    INDEX     h   CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public            postgres    false    209            �           1259    35428 (   auth_group_permissions_group_id_b120cbf9    INDEX     o   CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
 <   DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
       public            postgres    false    211            �           1259    35429 -   auth_group_permissions_permission_id_84c5c92e    INDEX     y   CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);
 A   DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
       public            postgres    false    211            �           1259    35414 (   auth_permission_content_type_id_2f476e4b    INDEX     o   CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);
 <   DROP INDEX public.auth_permission_content_type_id_2f476e4b;
       public            postgres    false    207            �           1259    35444 "   auth_user_groups_group_id_97559544    INDEX     c   CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);
 6   DROP INDEX public.auth_user_groups_group_id_97559544;
       public            postgres    false    215            �           1259    35443 !   auth_user_groups_user_id_6a12ed8b    INDEX     a   CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);
 5   DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
       public            postgres    false    215            �           1259    35458 1   auth_user_user_permissions_permission_id_1fbb5f2c    INDEX     �   CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);
 E   DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
       public            postgres    false    217            �           1259    35457 +   auth_user_user_permissions_user_id_a95ead1b    INDEX     u   CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);
 ?   DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
       public            postgres    false    217            �           1259    35485     auth_user_username_6821ab7c_like    INDEX     n   CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);
 4   DROP INDEX public.auth_user_username_6821ab7c_like;
       public            postgres    false    213            �           1259    35481 )   django_admin_log_content_type_id_c4bce8eb    INDEX     q   CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
 =   DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
       public            postgres    false    219            �           1259    35482 !   django_admin_log_user_id_c564eba6    INDEX     a   CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
 5   DROP INDEX public.django_admin_log_user_id_c564eba6;
       public            postgres    false    219            �           1259    35501 #   django_session_expire_date_a5c62663    INDEX     e   CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
 7   DROP INDEX public.django_session_expire_date_a5c62663;
       public            postgres    false    220            �           1259    35500 (   django_session_session_key_c0390e0f_like    INDEX     ~   CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public            postgres    false    220            �           1259    35604     shop_category_name_11b68823_like    INDEX     n   CREATE INDEX shop_category_name_11b68823_like ON public.shop_category USING btree (name varchar_pattern_ops);
 4   DROP INDEX public.shop_category_name_11b68823_like;
       public            postgres    false    222            �           1259    35607 !   shop_client_address_db54efcf_like    INDEX     p   CREATE INDEX shop_client_address_db54efcf_like ON public.shop_client USING btree (address varchar_pattern_ops);
 5   DROP INDEX public.shop_client_address_db54efcf_like;
       public            postgres    false    224            �           1259    35605    shop_client_email_f9da64da_like    INDEX     l   CREATE INDEX shop_client_email_f9da64da_like ON public.shop_client USING btree (email varchar_pattern_ops);
 3   DROP INDEX public.shop_client_email_f9da64da_like;
       public            postgres    false    224            �           1259    35606    shop_client_phone_f28b12b1_like    INDEX     l   CREATE INDEX shop_client_phone_f28b12b1_like ON public.shop_client USING btree (phone varchar_pattern_ops);
 3   DROP INDEX public.shop_client_phone_f28b12b1_like;
       public            postgres    false    224            �           1259    35608     shop_discount_name_3723fbe6_like    INDEX     n   CREATE INDEX shop_discount_name_3723fbe6_like ON public.shop_discount USING btree (name varchar_pattern_ops);
 4   DROP INDEX public.shop_discount_name_3723fbe6_like;
       public            postgres    false    226            �           1259    35609 !   shop_employee_email_c9ec26ba_like    INDEX     p   CREATE INDEX shop_employee_email_c9ec26ba_like ON public.shop_employee USING btree (email varchar_pattern_ops);
 5   DROP INDEX public.shop_employee_email_c9ec26ba_like;
       public            postgres    false    228            �           1259    35610 !   shop_employee_phone_fc1acf9d_like    INDEX     p   CREATE INDEX shop_employee_phone_fc1acf9d_like ON public.shop_employee USING btree (phone varchar_pattern_ops);
 5   DROP INDEX public.shop_employee_phone_fc1acf9d_like;
       public            postgres    false    228            �           1259    35653 "   shop_employee_position_id_d359c108    INDEX     c   CREATE INDEX shop_employee_position_id_d359c108 ON public.shop_employee USING btree (position_id);
 6   DROP INDEX public.shop_employee_position_id_d359c108;
       public            postgres    false    228            �           1259    35650    shop_order_client_id_5ef2b3ba    INDEX     Y   CREATE INDEX shop_order_client_id_5ef2b3ba ON public.shop_order USING btree (client_id);
 1   DROP INDEX public.shop_order_client_id_5ef2b3ba;
       public            postgres    false    236            �           1259    35651    shop_order_employee_id_abfbf4ff    INDEX     ]   CREATE INDEX shop_order_employee_id_abfbf4ff ON public.shop_order USING btree (employee_id);
 3   DROP INDEX public.shop_order_employee_id_abfbf4ff;
       public            postgres    false    236            �           1259    35652    shop_order_product_id_0eef2166    INDEX     [   CREATE INDEX shop_order_product_id_0eef2166 ON public.shop_order USING btree (product_id);
 2   DROP INDEX public.shop_order_product_id_0eef2166;
       public            postgres    false    236            �           1259    35611     shop_position_name_5c8bee57_like    INDEX     n   CREATE INDEX shop_position_name_5c8bee57_like ON public.shop_position USING btree (name varchar_pattern_ops);
 4   DROP INDEX public.shop_position_name_5c8bee57_like;
       public            postgres    false    230            �           1259    35615 #   shop_producer_address_cab58f75_like    INDEX     t   CREATE INDEX shop_producer_address_cab58f75_like ON public.shop_producer USING btree (address varchar_pattern_ops);
 7   DROP INDEX public.shop_producer_address_cab58f75_like;
       public            postgres    false    232            �           1259    35613 !   shop_producer_email_57b7f300_like    INDEX     p   CREATE INDEX shop_producer_email_57b7f300_like ON public.shop_producer USING btree (email varchar_pattern_ops);
 5   DROP INDEX public.shop_producer_email_57b7f300_like;
       public            postgres    false    232            �           1259    35612     shop_producer_name_e85e094e_like    INDEX     n   CREATE INDEX shop_producer_name_e85e094e_like ON public.shop_producer USING btree (name varchar_pattern_ops);
 4   DROP INDEX public.shop_producer_name_e85e094e_like;
       public            postgres    false    232            �           1259    35614 !   shop_producer_phone_d9795e72_like    INDEX     p   CREATE INDEX shop_producer_phone_d9795e72_like ON public.shop_producer USING btree (phone varchar_pattern_ops);
 5   DROP INDEX public.shop_producer_phone_d9795e72_like;
       public            postgres    false    232            �           1259    35632 !   shop_product_category_id_14d7eea8    INDEX     a   CREATE INDEX shop_product_category_id_14d7eea8 ON public.shop_product USING btree (category_id);
 5   DROP INDEX public.shop_product_category_id_14d7eea8;
       public            postgres    false    234            �           1259    35633 !   shop_product_discount_id_879e08ca    INDEX     a   CREATE INDEX shop_product_discount_id_879e08ca ON public.shop_product USING btree (discount_id);
 5   DROP INDEX public.shop_product_discount_id_879e08ca;
       public            postgres    false    234            �           1259    35631    shop_product_name_b8d5e94c_like    INDEX     l   CREATE INDEX shop_product_name_b8d5e94c_like ON public.shop_product USING btree (name varchar_pattern_ops);
 3   DROP INDEX public.shop_product_name_b8d5e94c_like;
       public            postgres    false    234            �           1259    35634 !   shop_product_producer_id_d2917a4f    INDEX     a   CREATE INDEX shop_product_producer_id_d2917a4f ON public.shop_product USING btree (producer_id);
 5   DROP INDEX public.shop_product_producer_id_d2917a4f;
       public            postgres    false    234                       2620    35663    shop_employee add_employee    TRIGGER     ~   CREATE TRIGGER add_employee AFTER INSERT ON public.shop_employee FOR EACH ROW EXECUTE FUNCTION public.trigger_add_employee();
 3   DROP TRIGGER add_employee ON public.shop_employee;
       public          postgres    false    238    228                       2620    35665    shop_discount check_price    TRIGGER     �   CREATE TRIGGER check_price BEFORE INSERT OR UPDATE ON public.shop_discount FOR EACH ROW EXECUTE FUNCTION public.trigger_check_discount_price();
 2   DROP TRIGGER check_price ON public.shop_discount;
       public          postgres    false    226    252                       2620    35666    shop_product check_product    TRIGGER     �   CREATE TRIGGER check_product BEFORE INSERT OR UPDATE ON public.shop_product FOR EACH ROW EXECUTE FUNCTION public.trigger_for_product();
 3   DROP TRIGGER check_product ON public.shop_product;
       public          postgres    false    234    253                       2620    35664    shop_employee delete_employee    TRIGGER     �   CREATE TRIGGER delete_employee AFTER DELETE ON public.shop_employee FOR EACH ROW EXECUTE FUNCTION public.trigger_delete_employee();
 6   DROP TRIGGER delete_employee ON public.shop_employee;
       public          postgres    false    251    228            �           2606    35423 O   auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
       public          postgres    false    2970    207    211            �           2606    35418 P   auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public          postgres    false    209    2975    211            �           2606    35409 E   auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
       public          postgres    false    205    207    2965                       2606    35438 D   auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
       public          postgres    false    2975    209    215                        2606    35433 B   auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
       public          postgres    false    2983    213    215                       2606    35452 S   auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
       public          postgres    false    217    2970    207                       2606    35447 V   auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
       public          postgres    false    2983    217    213                       2606    35471 G   django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
       public          postgres    false    2965    205    219                       2606    35476 B   django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
       public          postgres    false    213    219    2983                       2606    35599 D   shop_employee shop_employee_position_id_d359c108_fk_shop_position_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_employee
    ADD CONSTRAINT shop_employee_position_id_d359c108_fk_shop_position_id FOREIGN KEY (position_id) REFERENCES public.shop_position(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.shop_employee DROP CONSTRAINT shop_employee_position_id_d359c108_fk_shop_position_id;
       public          postgres    false    3041    230    228            
           2606    35635 :   shop_order shop_order_client_id_5ef2b3ba_fk_shop_client_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_client_id_5ef2b3ba_fk_shop_client_id FOREIGN KEY (client_id) REFERENCES public.shop_client(id) DEFERRABLE INITIALLY DEFERRED;
 d   ALTER TABLE ONLY public.shop_order DROP CONSTRAINT shop_order_client_id_5ef2b3ba_fk_shop_client_id;
       public          postgres    false    236    224    3022                       2606    35640 >   shop_order shop_order_employee_id_abfbf4ff_fk_shop_employee_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_employee_id_abfbf4ff_fk_shop_employee_id FOREIGN KEY (employee_id) REFERENCES public.shop_employee(id) DEFERRABLE INITIALLY DEFERRED;
 h   ALTER TABLE ONLY public.shop_order DROP CONSTRAINT shop_order_employee_id_abfbf4ff_fk_shop_employee_id;
       public          postgres    false    236    3035    228                       2606    35645 <   shop_order shop_order_product_id_0eef2166_fk_shop_product_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_product_id_0eef2166_fk_shop_product_id FOREIGN KEY (product_id) REFERENCES public.shop_product(id) DEFERRABLE INITIALLY DEFERRED;
 f   ALTER TABLE ONLY public.shop_order DROP CONSTRAINT shop_order_product_id_0eef2166_fk_shop_product_id;
       public          postgres    false    3062    236    234                       2606    35616 B   shop_product shop_product_category_id_14d7eea8_fk_shop_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_category_id_14d7eea8_fk_shop_category_id FOREIGN KEY (category_id) REFERENCES public.shop_category(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_category_id_14d7eea8_fk_shop_category_id;
       public          postgres    false    234    222    3011                       2606    35621 B   shop_product shop_product_discount_id_879e08ca_fk_shop_discount_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_discount_id_879e08ca_fk_shop_discount_id FOREIGN KEY (discount_id) REFERENCES public.shop_discount(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_discount_id_879e08ca_fk_shop_discount_id;
       public          postgres    false    234    3027    226            	           2606    35626 B   shop_product shop_product_producer_id_d2917a4f_fk_shop_producer_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_producer_id_d2917a4f_fk_shop_producer_id FOREIGN KEY (producer_id) REFERENCES public.shop_producer(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_producer_id_d2917a4f_fk_shop_producer_id;
       public          postgres    false    232    3055    234            �   O   x���v
Q���W((M��L�K,-ɈO/�/-Ps�	uV�0�QPO�-�ɯLMU״��$J�PWnb^bzjH }-!�      �   I  x����J�@��}�b�
"�9��W.�H[�-���1���_��e`��9����>��}�����x��|��Χe:L���q���ל�n�7�t������M5�;.���Ů�Cq(�Qܬ��(ngw��{��s��]w�1c����مg)sx��<[΂}�,h�>w��0V�Z8�e-�L��`C��=l>ϊjx��fo��j��J�f�K��p��V5s^:��y�U3�V�f�M֌Y3Y3�<e�s�58�M��<7Y���d͙5�5g�L֜YsYsf�e͙5�5g�\��S�5g�\���vY���e�o�5��]���Y��;d�uW��?��      �   �  x���Mk�@����B(�,�Sq}0�$4i���G�HB-���vgꙑ���cx��}G�����gs�~0u����O��{}�m�m^���o?O�Ctkn��Ҝ����زk.7�f���a�G?/���������l'�k�%��-l7��X�'����	=���$}�{�c����5{�C�j��������'��\m�H����A]B��w���	9�؈gLY�W��4Z��TU�$ڷ��u?���ID�S��x��05�fIH�ܐ$Ӫ�S�t���
����[�� �w\c�s��䭿F|Gc�����>m���ɳ���@T�w!w%-ڏ���f��a����ͷ/��>��p?$E�1k,����,�`Vr���
����TY���
�nW�ḋ���-�i\#t4k:�B�Ҷ{�ڼ��#�Q +ZO���'p�Y���Z	�6���iջ7�-\c��]у�����h@�C�J=a�'m��V��wx���b�B����,��'iH[���:���Y�Iۥ��W�s�m�Q�N��2Y��W����f��׷��j�#;\���?u�\�x��Kq�/�QҸw(uэR��C��z���@�2mȇ&���+7E92BV����\V�Lu��3���)T       �   a  x���[O�@���� �n֭s>t�ɊD�� 7f�N�m����E7�(�ސ�͗v���<3�������n�u>_�Qy�x�S�X��qsh}A���"Ԋaɹ'021L|�1�Bp���{�S�W�ԔL�^�[cP��>R���F�t�+M��!F�z
U�rt�o�$7��6|���,]�\B�8A����'��I��NRs3�HA�k��&�k�KÁF�`z\%���]�A�qo���c�gտ�\z\j�!.ՀIBaBB�*�J�T�.@]E^�,�h�cS�3A��II(����`�	у��"ۘmU�^�r��h�i=_z>z,�/���  ���2�n���Z˰�H�����ф]����E�:�A_���Yخ76�O�c6�b� �%�U��&*G��$&�v*�q�-�Ӿ	xl䐉�b1�/��x6����h�X�wv���U�����4��՘�o��fw�|^t>1����)�sdG��(��㑚�$R�|��tBpl�"�z2�����6n���i"��>o&����{�jn�+��0���?���6����K��I�C��xCP^D����#�.�.BE@H��xr��b��      �   f   x���v
Q���W((M��L�K,-Ɉ/-N-�O/�/-(Vs�	uV�04�Q0�Q0Դ��$E����1�Lu�:�H�f��`J�m�:
fdh��Q0�h�� 7e      �   
   x���          �   �  x���]O�0���Voش-���8���&6�BȫcR�m֐�e)���"%'��֏�s��LO�N������Wr��g��2���fum�b������󗋓3�~$�,g�'�� 9�X^Q�	V��~��1L��5���G2�𷗏cmc'y|z��Q���h�
6D�DƵԜo(�蝉�E�&X�G� :�y!�d,����7	p���$���!"^d���H`�3��=�<��rBgJ��U"��	��Fk|�<˕(�ڀR�)1)lH�2nѪA�"�T�mX�t�x]�`l�~�]&�*YV���g�ogF�����xc�$C���@\�MH6Dx�]">�Vog�C̒sI���ٽ�v����� l���^�_��*���k�um��a��?L� ��Ih��L�RK������5����B�!Zd�S�d�uB��h����b�!p@)��;Yq!Z�wq}��bhm!�#PZ�����"�N�d����`칅�nL��pjh�Ţ �!`)3]��~ဇ���Z$l��T�6�d��\��ْ�wK�b?���}��퀪*W���� �/�/x�����M��[�¿v7o�Mp{9���-�)�W�4�����T�&�F��A�|GمY����?���� ��H      �   �   x���;�  ཿ���#��89841��ZMR1-Gx����q򶃃/p���=�I�?���Z�1����r7�jA���e{":"i����P��M�����:ǻG�hai�����x�0���0b�~ݼM��q+����'FH�n�t�Z�<YF�6�=�(�X+�Ft9\Zu)J#G4��V`zE���^��V�NT��]t9`��0I��EFD      �     x���Ao� �������0�N;�iꤵ���:L�x�����t��Xu���y?��������~_ln��������-�ƊV7Nm;_������]q?˭��B���/�;  
�頥I� p�5��kB֤ZUŐ}������=D�(���K�cHsHe"խ�f�8g(��PH��;u{�Tk��%[!�z���$M���+:�ܦ����FlwVo�=�(T�H�.���~�iSt�U�
(����S��4A9�+�j��$�h�0�k�^��p�'��%�G	���j�6s�<>8���t|JOˡ|ۇI�9Ĕeu4c69e�CJ��f��8�d��1����3h�/v�H��IxYb���gӌK�F�2X�M���N��{�L��dy˱
v�����+s�� ���"0W�e�d� ����١�Mg1����x(�>@��٧���v�^�u�x�Atz��ͽ}���CY^ ����ķ��y�J.�;���T��lE0$��t[,�y�W      �   2  x���n�@  л_��6�f��'ʢ���^˰�a1|}��O7]����,b���JYwEa�q�wD ]}�%�Ha��Y��m�� ����T�y���y@�+��Z+�vPt���2��L~kN�:�C�OπG\<HK-9��V��x�&�5Z%�����_c�ٶ�~�YVJ���3���=e�n����=u{�Ɛ:��`8`K��
���Su�1�'����d=�xŸ�"G�d�H5������y�'P5z��J�"E(7i^3^�U�]�,Q�1k �߄ �=��# #�Pd��c�1�&߿v��X�l�      �   f   x���v
Q���W((M��L�+��/�ON,IM�/�Ts�	uV�0�QP�	�9)��Ɇ��\��a�d��#��0F2�f�1IF� a3�d �S�      �     x����N�0�=_��f(7�bbH42�y�PZ�2���h�"��6���i�囇��f�;�=�H*VV�����������M�~p��M0�����Z�.��X�tO�pߠi%��U$W�g�%�1��%���Ҡ�apz��3D�OP�#t�\Ȩ���"�-@�����_.�{�^�γ����<[0���R�8��Z�����WHN�,#�2��`z00��w��nP���W���gQ41pg�-V�l      �   p   x���v
Q���W((M��L�+��/�O�,N�/�+Qs�	uV�0�QP�	��8��� ��������5�'�F!e3
�0"�(c$��aF��$e�d�	�(�f w�Y�      �   %  x���OO�@��|���h�ۥ,ċ94hI����,eB'mw���o���A{ټ�d�/o^m���x��6�dT�T~BQ��xo����ƻ�o��|/k94�
Y�N�eI9��*74?a��/$棄
���"���>�bj��~��̍�u�~M;$E�^0K~�g��L���1XV��b��d��G�{��	��]�3�,��,4���^K�;st+#̤"M-&�O:;O��w��=��{�����T�Fgxc��ҙ����Y_�p��~I
�w�W
+,���N?���7v��      �   �   x���=�0�=��(��\�����! lu� �����H@nL�w8�'��B׷�B7`�^߯�����8�3�w�S��J Q�*�.5�h���Y r��q���*�2n�l��!��20�2>�(���:XT��O�[x4�D�����߁#@����t      �   ]   x���v
Q���W((M��L�+��/�/�/�,���Ss�	uV�0�QPO�-�ɯLMU�Q040�30д��$� #���y��E@�F0�\\ ��'      �   �   x���v
Q���W((M��L�+��/�/(�O)MN-Rs�	uV�0�QP
�e���9����9�F�� �^r~.HT������������$���R�Z\lh��i��I�mFH�!�f��6C4�A�qq �NA*      �   �   x����
�@�Oqv2WSZ�p!�Aj�(+
���gZs�f?��	�$إ����T�s���ա��s����DY����_w�&gQD�)J�C)���.�� ����
�d9�Y>e�(�Y�Y��^�Eӳ��0K+����Ӱb�MT���곂IZ>.�E�ծ�51f�v��
'6Okނ��������2��G�תP������o�����}Y��!�U     