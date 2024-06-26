-- Удалите внешний ключ из sales
alter table public.sales drop constraint sales_products_product_id_fk;

-- Удалите первичный ключ из products
alter table public.products drop constraint products_pk;

-- Добавьте новое поле id для суррогантного ключа в products
alter table public.products add id serial;

-- Сделайте данное поле первичным ключом
alter table public.products add constraint products_pk primary key (id);

-- Добавьте дату начала действия записи в products
alter table public.products add valid_from timestamptz;

-- Добавьте дату окончания действия записи в products
alter table public.products add valid_to timestamptz;

-- Добавьте новый внешний ключ sales_products_id_fk в sales
alter table public.sales add constraint sales_products_id_fk foreign key (product_id) references products (id);