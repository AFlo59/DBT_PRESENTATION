WITH DT_SRC AS (
    SELECT
        *
    FROM
        {{ source('SEED', 'ORDERS') }}
)
SELECT
    *
FROM
    DT_SRC