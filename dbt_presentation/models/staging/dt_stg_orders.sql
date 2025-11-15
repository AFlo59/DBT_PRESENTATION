
{%- set columns_to_standardize = [
    {'name': 'order_id', 'type': 'VARCHAR', 'length': 6},
    {'name': 'customer_id', 'type': 'VARCHAR', 'length': 5},
    {'name': 'product_id', 'type': 'VARCHAR', 'length': 4},
    {'name': 'product_name', 'type': 'VARCHAR', 'length': 64},
    {'name': 'order_date', 'type': 'DATE', 'length': None},
    {'name': 'quantity', 'type': 'NUMBER', 'length': None},
    {'name': 'unit_price', 'type': 'NUMBER', 'length': None},
    {'name': 'total_amount', 'type': 'NUMBER', 'length': None},
    {'name': 'status', 'type': 'VARCHAR', 'length': 32},
    {'name': 'region', 'type': 'VARCHAR', 'length': 32},
    {'name': 'customer_segment', 'type': 'VARCHAR', 'length': 32}
] -%}

WITH DT_STG AS (
    SELECT
        {%- for col in columns_to_standardize %}
        {{ standardize_column(col.name, col.type, col.length) }} AS {{ col.name | upper }}{%- if not loop.last %},{%- endif %}
        {%- endfor %}
    FROM
        {{ ref('dt_src_orders') }}
)
SELECT
    *,
    {{ get_load_columns() }}
FROM
    DT_STG