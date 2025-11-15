WITH DT_SILVER AS (
    SELECT
        K.ORDER_ID,
        K.CUSTOMER_ID,
        K.PRODUCT_ID,
        O.ORDER_DATE,
        O.STATUS,
        C.REGION,
        C.CUSTOMER_SEGMENT,
        P.PRODUCT_NAME,
        P.UNIT_PRICE
    FROM
        {{ ref('dt_key') }} K
    INNER JOIN
        {{ ref('dt_orders') }} O
        ON K.ORDER_ID = O.ORDER_ID
    INNER JOIN
        {{ ref('dt_customers') }} C
        ON K.CUSTOMER_ID = C.CUSTOMER_ID
    INNER JOIN
        {{ ref('dt_products') }} P
        ON K.PRODUCT_ID = P.PRODUCT_ID
)
SELECT
    *,
    CURRENT_TIMESTAMP() AS LOAD_DATE,
    CURRENT_DATE() AS LOAD_DATE_DAY,
    TO_VARCHAR(CURRENT_DATE(),'YYYY-MM') AS LOAD_DATE_MONTH
FROM
    DT_SILVER
GROUP BY
    ORDER_ID,
    CUSTOMER_ID,
    PRODUCT_ID,
    ORDER_DATE,
    STATUS,
    REGION,
    CUSTOMER_SEGMENT,
    PRODUCT_NAME,
    UNIT_PRICE

