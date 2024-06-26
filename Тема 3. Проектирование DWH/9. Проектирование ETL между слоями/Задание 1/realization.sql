
with sums as(
select 
	dr.restaurant_id,
	dr.restaurant_name,
	dt."date" as settlement_date,
	count(distinct o.id) as orders_count,
	sum(fps.total_sum) as orders_total_sum,
	sum(fps.bonus_payment) as orders_bonus_payment_sum,
	sum(fps.bonus_grant) as orders_bonus_granted_sum,
	sum(fps.total_sum)*0.25 as order_processing_fee
from dds.fct_product_sales fps
	join DDS.dm_orders o on o.id = fps.order_id
	join dds.dm_timestamps dt on dt.id = o.timestamp_id
	join dds.dm_restaurants dr on dr.id = o.restaurant_id
where o.order_status = 'CLOSED'
group by dt.date, dr.id, dr.restaurant_name
)
insert into cdm.dm_settlement_report (
	restaurant_id, restaurant_name, settlement_date, orders_count, orders_total_sum,
	orders_bonus_payment_sum, orders_bonus_granted_sum, order_processing_fee, restaurant_reward_sum
	)
select
	s.restaurant_id,
	s.restaurant_name,
	s.settlement_date,
	s.orders_count,
	s.orders_total_sum,
	s.orders_bonus_payment_sum,
	s.orders_bonus_granted_sum,
	s.order_processing_fee,
	s.orders_total_sum - s.order_processing_fee - s.orders_bonus_payment_sum as restaurant_reward_sum
from sums as s;