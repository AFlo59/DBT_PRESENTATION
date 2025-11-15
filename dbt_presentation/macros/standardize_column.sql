{% macro standardize_column(column_name, data_type, max_length=null) %}
    {#-
        Macro pour standardiser les colonnes : trim, upper, nullif
        Utile pour nettoyer les données sources
        
        Args:
            column_name: nom de la colonne à standardiser
            data_type: type de données (VARCHAR, NUMBER, DATE)
            max_length: longueur maximale pour VARCHAR (optionnel)
    -#}
    {%- if data_type == 'VARCHAR' -%}
        CAST(UPPER(NULLIF(TRIM({{ column_name }}), '')) AS VARCHAR({{ max_length }}))
    {%- elif data_type == 'NUMBER' -%}
        CAST(NULLIF(TRIM({{ column_name }}), '') AS NUMBER(38,2))
    {%- elif data_type == 'DATE' -%}
        CAST(NULLIF(TRIM({{ column_name }}), '') AS DATE)
    {%- else -%}
        {{ column_name }}
    {%- endif -%}
{% endmacro %}

