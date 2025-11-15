{% macro add_constraints() %}
    {#-
        Macro pour ajouter des contraintes PRIMARY KEY et FOREIGN KEY (NOT ENFORCED) sur Snowflake
        Utilisée dans les post-hooks des modèles table et incremental
        Lit les contraintes depuis model.config.constraints défini dans les fichiers _schemas.yml
    -#}
    {%- set constraints = model.config.get('constraints', {}) -%}
    {%- set primary_keys = constraints.get('primary_key', {}).get('columns', []) -%}
    {%- set foreign_keys = constraints.get('foreign_keys', []) -%}
    {%- set model_name = this.identifier | lower -%}
    
    {%- if primary_keys or foreign_keys -%}
        {#- Ajout des contraintes PRIMARY KEY -#}
        {%- if primary_keys -%}
            {%- set pk_columns = primary_keys | join(', ') -%}
            {%- set pk_name = 'pk_' ~ model_name -%}
            {%- call statement('add_pk', fetch_result=False) -%}
                ALTER TABLE {{ this }} ADD CONSTRAINT {{ pk_name }} PRIMARY KEY ({{ pk_columns }}) NOT ENFORCED;
            {%- endcall -%}
        {%- endif -%}
        
        {#- Ajout des contraintes FOREIGN KEY -#}
        {%- if foreign_keys -%}
            {%- for fk in foreign_keys -%}
                {%- set fk_columns = fk.columns | join(', ') -%}
                {%- set fk_reference_table = fk.references | trim | lower -%}
                {%- set fk_name = 'fk_' ~ model_name ~ '_' ~ fk_reference_table -%}
                {%- set fk_reference = ref(fk.references) ~ '(' ~ fk.columns[0] ~ ')' -%}
                {%- call statement('add_fk_' ~ loop.index, fetch_result=False) -%}
                    ALTER TABLE {{ this }} ADD CONSTRAINT {{ fk_name }} FOREIGN KEY ({{ fk_columns }}) REFERENCES {{ fk_reference }} NOT ENFORCED;
                {%- endcall -%}
            {%- endfor -%}
        {%- endif -%}
    {%- endif -%}
{% endmacro %}

