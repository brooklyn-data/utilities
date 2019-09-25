{#
Given a US ZIP code which might be in traditional 5-digit format, ZIP+4 format,
or even possibly a mangled format where leading zeros have been accidentally
removed from a 5-digit ZIP code (e.g. by Excel), return a normalized 5-digit ZIP code.
#}
{% macro us_5_digit_zip_code(zip_code) -%}

    case
        when {{ utilities.regex_like(zip_code, '[0-9]{5}.*|[0-9]{1,4}') }}
            then repeat('0', 5 - len({{zip_code}})) || left({{zip_code}}, 5)
        else null
    end

{%- endmacro %}
