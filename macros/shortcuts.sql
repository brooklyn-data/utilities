{%- macro convert_tz (column_name, timezone='EST') -%}
	convert_timezone('{{timezone}}', {{column_name}}) as {{column_name[(column_name.find('.')+1):] + '_' + timezone.lower()}}
{%- endmacro -%}