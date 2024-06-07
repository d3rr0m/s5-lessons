select 
	t.table_name,
	c.column_name,
	c.data_type,
	c.character_maximum_length,
	c.column_default,
	c.is_nullable 
from information_schema.tables t
inner join information_schema.columns c on t.table_schema = c.table_schema and t.table_name = c.table_name 
where t.table_schema = 'public';