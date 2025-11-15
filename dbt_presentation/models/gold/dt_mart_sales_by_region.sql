{{ config(
    materialized='incremental',
    unique_key=['REGION', 'CUSTOMER_SEGMENT', 'LOAD_DATE_MONTH'],
    on_schema_change='append_new_columns'
) }}

WITH DT_MART AS (
    SELECT
        C.REGION,
        C.CUSTOMER_SEGMENT,
        COUNT(DISTINCT O.ORDER_ID) AS TOTAL_ORDERS,
        COUNT(DISTINCT K.CUSTOMER_ID) AS TOTAL_CUSTOMERS,
        COUNT(DISTINCT K.PRODUCT_ID) AS TOTAL_PRODUCTS,
        SUM(STG.QUANTITY) AS TOTAL_QUANTITY,
        SUM(STG.TOTAL_AMOUNT) AS TOTAL_REVENUE,
        AVG(STG.TOTAL_AMOUNT) AS AVG_ORDER_VALUE,
        MIN(O.ORDER_DATE) AS FIRST_ORDER_DATE,
        MAX(O.ORDER_DATE) AS LAST_ORDER_DATE
    FROM
        {{ ref('dt_orders') }} O
    INNER JOIN
        {{ ref('dt_key') }} K
        ON O.ORDER_ID = K.ORDER_ID
    INNER JOIN
        {{ ref('dt_customers') }} C
        ON K.CUSTOMER_ID = C.CUSTOMER_ID
    INNER JOIN
        {{ ref('dt_stg_orders') }} STG
        ON K.ORDER_ID = STG.ORDER_ID
        AND K.CUSTOMER_ID = STG.CUSTOMER_ID
        AND K.PRODUCT_ID = STG.PRODUCT_ID
    WHERE
        1=1
        {#- Filtre optionnel : décommentez pour filtrer uniquement les commandes 'Completed' -#}
        {#- AND O.STATUS = 'Completed' -#}
    {% if is_incremental() %}
        AND TO_VARCHAR(O.ORDER_DATE, 'YYYY-MM') >= COALESCE((SELECT MAX(LOAD_DATE_MONTH) FROM {{ this }}), '1900-01')
    {% endif %}
    GROUP BY
        C.REGION,
        C.CUSTOMER_SEGMENT
)
SELECT
    *,
    CURRENT_TIMESTAMP() AS LOAD_DATE,
    CURRENT_DATE() AS LOAD_DATE_DAY,
    TO_VARCHAR(CURRENT_DATE(),'YYYY-MM') AS LOAD_DATE_MONTH
FROM
    DT_MART
ORDER BY
    REGION,
    CUSTOMER_SEGMENT,
    LOAD_DATE_MONTH

