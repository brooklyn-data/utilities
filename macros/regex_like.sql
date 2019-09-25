{# Return whether the given column's entire value matches the given regular expression. #}
{% macro regex_like(column, regex) -%}
    {#- Backslash escapes in the regex string get decoded when it's passed in, so we need to restore those. -#}
    {{ adapter_macro('utilities.regex_like', column, regex.replace('\\', '\\\\')) }}
{%- endmacro %}


{% macro bigquery__regex_like(column, regex) -%}

    regexp_contains({{column}}, '^({{regex}})$')

{%- endmacro %}


{% macro redshift__regex_like(column, regex) -%}

    {{column}} ~ '^({{regex}})$'

{%- endmacro %}


{% macro snowflake__regex_like(column, regex) -%}

    {#- Snowflake implicitly anchors the regular expression pattern at both ends. -#}
    {{column}} rlike '{{regex}}'

{%- endmacro %}
