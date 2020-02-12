{% macro test_not_null_where(model, column_name, where_clause) %}

select count(*)

from {{ model }}

where
	{{ column_name }} is null and
	{{ where_clause }}

{% endmacro %}


{% macro test_equal_value(model, column_name, comparison_value, where_clause=none, table_override=none, aggregate_key=none, precision_amount=0) %}

{%- if table_override is not none -%}
	with cte_aggregation as (
		select
			{{ aggregate_key }},
			{{ comparison_value }} as comp_value

		from {{ table_override }}

		group by 1
	)

	select count(*)

	from {{ model }}

	join cte_aggregation using({{ aggregate_key }})

	where abs({{ column_name }} - comp_value) > {{ precision_amount }}
		{% if where_clause is not none %} and {{ where_clause }} {% endif %}

{%- else -%}

select count(*)

from {{ model }}

where abs({{ column_name }} - ({{ comparison_value }})) >  {{ precision_amount }}
	{% if where_clause is not none %} and {{ where_clause }} {% endif %}

{%- endif -%}
{% endmacro %}
