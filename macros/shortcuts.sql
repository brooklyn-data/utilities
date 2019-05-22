{%- macro convert_tz (column_name, tz='{{var("timezone")}}', tz_alias='{{var("timezone_alias")}}') -%}
	convert_timezone('{{tz}}', {{column_name}}) as {{column_name[(column_name.find('.')+1):] + '_' + tz_alias.lower()}}
{%- endmacro -%}