drop table if exists clients;
CREATE TABLE clients
(
    client_id INTEGER NOT NULL
        CONSTRAINT clients_pk PRIMARY KEY,
    name      TEXT    NOT NULL,
    login     TEXT    NOT NULL
);
drop table if exists products;
CREATE TABLE products
(
    product_id INTEGER        NOT NULL
        CONSTRAINT products_pk PRIMARY KEY,
    name       TEXT           NOT NULL,
    price      NUMERIC(14, 2) NOT NULL
);
drop table if exists sales;
CREATE TABLE sales
(
    client_id  INTEGER        NOT NULL
        CONSTRAINT sales_clients_client_id_fk REFERENCES clients,
    product_id INTEGER        NOT NULL
        CONSTRAINT sales_products_product_id_fk REFERENCES products,
    amount     INTEGER        NOT NULL,
    total_sum  NUMERIC(14, 2) NOT NULL,
    CONSTRAINT sales_pk PRIMARY KEY (client_id, product_id)
);

alter table public.sales drop constraint sales_products_id_fk;
alter table public.products drop constraint products_pk;
alter table products drop id;
alter table public.products add id serial;
alter table public.products add constraint products_pk primary key (id);
--alter table public.products add valid_from timestamptz;
--alter table public.products add valid_to timestamptz;
alter table public.sales add constraint sales_products_id_fk foreign key (product_id) references products (id);

alter table sales drop constraint sales_products_product_id_fk;

alter table products drop constraint products_pk;

alter table products add id serial;

alter table products add constraint products_pk primary key (id);

alter table products add valid_from timestamptz;

alter table products add valid_to timestamptz;

alter table sales add constraint sales_products_id_fk foreign key (product_id) references products;