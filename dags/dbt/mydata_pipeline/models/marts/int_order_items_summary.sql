select
    order_key,
    sum(extended_price)                                         as gross_item_sales_amount,
    sum(extended_price * (1 - discount_percentage))            as net_item_sales_amount,
    sum(extended_price * (1 - discount_percentage) * (1 + tax_rate)) as net_item_sales_amount_after_tax
from {{ ref('int_order_items') }}
group by order_key
