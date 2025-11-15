{% macro get_status_filter(status_list=['Completed']) %}
    {#-
        Macro pour filtrer par statut de commande
        Par défaut, filtre uniquement les commandes 'Completed'
        
        Args:
            status_list: liste des statuts à inclure (par défaut: ['Completed'])
    -#}
    {%- if status_list -%}
        STATUS IN (
        {%- for status in status_list -%}
            '{{ status }}'{%- if not loop.last %},{%- endif %}
        {%- endfor -%}
        )
    {%- else -%}
        1=1
    {%- endif -%}
{% endmacro %}

