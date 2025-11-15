{% macro get_load_columns() %}
    {#-
        Macro pour ajouter les colonnes de chargement standard
        Retourne les colonnes LOAD_DATE, LOAD_DATE_DAY, LOAD_DATE_MONTH
    -#}
    CURRENT_TIMESTAMP() AS LOAD_DATE,
    CURRENT_DATE() AS LOAD_DATE_DAY,
    TO_VARCHAR(CURRENT_DATE(),'YYYY-MM') AS LOAD_DATE_MONTH
{% endmacro %}

