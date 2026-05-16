select
    line_items.order_key,
    line_items.part_key,
    line_items.supplier_key,
    line_items.line_number,
    line_items.quantity,
    line_items.extended_price,
    line_items.discount_percentage,
    line_items.tax_rate,
    orders.customer_key,
    orders.status_code as order_status,
    orders.priority_code,
    orders.order_date,
    orders.ship_priority
from {{ ref('stg_tpch_line_items') }} as line_items
inner join {{ ref('stg_tpch_orders') }} as orders
    on line_items.order_key = orders.order_key
