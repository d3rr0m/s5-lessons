SELECT distinct (json_array_elements((event_value::JSON->>'product_payments')::JSON))::JSON->>'product_name' AS first_product_payment
FROM outbox;