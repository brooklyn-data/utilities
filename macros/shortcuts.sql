{%- macro convert_tz (column_name, timezone='America/New_York', timezone_alias='EST') -%}
	convert_timezone('{{timezone}}', {{column_name}}) as {{column_name[(column_name.find('.')+1):] + '_' + timezone_alias.lower()}}
{%- endmacro -%}