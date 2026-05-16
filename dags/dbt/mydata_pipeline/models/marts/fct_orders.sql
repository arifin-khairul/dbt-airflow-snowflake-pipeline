select
    orders.order_key,
    orders.customer_key,
    orders.status_code,
    orders.priority_code,
    orders.order_date,
    summary.gross_item_sales_amount,
    summary.net_item_sales_amount,
    summary.net_item_sales_amount_after_tax,
    summary.gross_item_sales_amount - summary.net_item_sales_amount as item_discount_amount
from {{ ref('stg_tpch_orders') }} as orders
inner join {{ ref('int_order_items_summary') }} as summary
    on orders.order_key = summary.order_key
