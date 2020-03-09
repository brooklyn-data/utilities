{%- macro convert_tz (column_name, tz=var("timezone"), tz_alias=var("timezone_alias"), cast=var('convert_tz_cast', none)) -%}
	{%- set expression -%}
		convert_timezone('{{tz}}', {{column_name}})
	{%- endset -%}

	{%- if cast -%}
		{%- set expression -%}
			cast({{expression}} as {{cast}})
		{%- endset -%}
	{%- endif -%}

	{{expression}} as {{column_name[(column_name.find('.')+1):] + '_' + tz_alias.lower()}}
{%- endmacro -%}
