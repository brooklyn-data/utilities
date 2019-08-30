--code source: https://discourse.looker.com/t/how-to-count-only-weekdays-between-two-dates/3345
{%- macro weekdays_between_dates(start, stop) -%}
(
date_diff('day', {{start}}, {{stop}}) -
(
    (
        floor (
            date_diff('day', {{start}}, {{stop}}) / 7
        ) * 2
    )
    + case
        when
            date_part(dow, {{start}}) - date_part(dow, {{stop}}) in (1, 2, 3, 4, 5) and
            date_part(dow, {{stop}}) != 0
            then 2
        else 0 end
    + case
        when
            date_part(dow, {{start}}) != 0 and
            date_part(dow, {{stop}}) = 0
            then 1
        else 0 end
    + case
        when
            date_part(dow, {{start}}) = 0 and
            date_part(dow, {{stop}}) != 0
            then 1
        else 0 end
)
)
{%- endmacro -%}
