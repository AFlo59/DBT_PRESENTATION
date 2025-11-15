{%- set bronze_columns = ['ORDER_ID', 'ORDER_DATE', 'STATUS'] -%}

WITH DT_BRONZE AS (
    SELECT
        DISTINCT
        {%- for col in bronze_columns %}
        {{ col }}{%- if not loop.last %},{%- endif %}
        {%- endfor %}
    FROM
        {{ ref('dt_stg_orders') }}
)
SELECT
    *,
    {{ get_load_columns() }}
FROM
    DT_BRONZE
GROUP BY
    {%- for col in bronze_columns %}
    {{ col }}{%- if not loop.last %},{%- endif %}
    {%- endfor %}
