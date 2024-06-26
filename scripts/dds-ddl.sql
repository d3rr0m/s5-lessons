create schema if not exists dds;

drop table if exists dds.dm_users; 
create table dds.dm_users(
	id serial constraint dm_users_pk primary key,
	user_id varchar not null,
	user_name varchar not null,
	user_login varchar not null
);

drop table if exists dds.dm_restaurants; 
create table dds.dm_restaurants(
	id serial constraint dm_restaurants_pk primary key,
	restaurant_id varchar not null,
	restaurant_name varchar not null,
	active_from timestamp not null,
	active_to timestamp not null
);

drop table if exists dds.dm_products; 
create table dds.dm_products(
	id serial constraint dm_products_pk primary key,
	product_id varchar not null,
	product_name varchar not null,
	product_price numeric(14, 2) default (0) constraint dm_products_product_price_check check (product_price >= 0) not null,
	restaurant_id int not null,
	active_from timestamp not null,
	active_to timestamp not null
);

alter table dds.dm_products add constraint dm_products_restaurant_id_fkey foreign key (restaurant_id) references dds.dm_restaurants(id);

drop table if exists dds.dm_timestamps; 
create table dds.dm_timestamps(
	id serial constraint dm_timestamps_pk primary key,
	ts timestamp not null,
	"year" smallint check ("year" >= 2022 and "year" < 2500) not null,
	"month" smallint check ("month" >= 1 and "month" <= 12) not null,
	"day" smallint check ("day" >= 1 and "day" <= 31) not null,
	"time" time not null,
	"date" date not null
);

drop table if exists dds.dm_orders; 
create table dds.dm_orders(
	id serial constraint dm_orders_pk primary key,
	restaurant_id int not null,
	user_id int not null,
	timestamp_id int not null,
	order_key varchar not null,
	order_status varchar not null
);

alter table dds.dm_orders add constraint dm_orders_restaurants_restaurant_id_fk foreign key (restaurant_id) references dds.dm_restaurants(id);
alter table dds.dm_orders add constraint dm_orders_restaurants_user_id_fk foreign key (user_id) references dds.dm_users(id);
alter table dds.dm_orders add constraint dm_orders_timestamps_timestamp_id_fk foreign key (timestamp_id) references dds.dm_timestamps(id);

drop table if exists dds.fct_product_sales; 
create table dds.fct_product_sales(
	id serial constraint fct_product_sales_pk primary key,
	product_id int not null,
	order_id int not null,
	"count" int not null default 0 constraint fct_product_sales_count_check check ("count" >= 0),
	price numeric(14, 2) not null default 0 constraint fct_product_sales_price_check check (price >= 0),
	total_sum numeric(14, 2) not null default 0 constraint fct_product_sales_total_sum_check check (total_sum >= 0),
	bonus_payment numeric(14, 2) not null default 0 constraint fct_product_sales_bonus_payment_check check (bonus_payment >= 0),
	bonus_grant numeric(14, 2) not null default 0 constraint fct_product_sales_bonus_grant_check check (bonus_grant >= 0)
);

alter table dds.fct_product_sales add constraint fct_product_sales_products_fk foreign key (product_id) references dm_products (id);
alter table dds.fct_product_sales add constraint fct_product_sales_orders_fk foreign key (order_id) references dm_orders (id);
