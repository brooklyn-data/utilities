--code source: https://discourse.looker.com/t/how-to-count-only-weekdays-between-two-dates/3345
--The calculation includes the start date, but not the stop date.
{%- macro weekdays_between_dates(start, stop) -%}
(
    datediff('day', {{start}}, {{stop}}) -
    (
        (
     -- Subtract one weekend for each complete week.
            floor (
                datediff('day', {{start}}, {{stop}}) / 7
            ) * 2
        )
    -- Take account of the scenario of incomplete weeks that include full weekends
    -- e.g. start date is Thursday, end date is the next Wednesday.
        + case
            when
                date_part(dayofweek, {{start}}) - date_part(dayofweek, {{stop}}) in (1, 2, 3, 4, 5) and
                date_part(dayofweek, {{stop}}) != 0
                then 2
            else 0 end
    -- Take account of the scenario of incomplete weeks where the stop day is a Sunday,
    -- and the start day is not.
        + case
            when
                date_part(dayofweek, {{start}}) != 0 and
                date_part(dayofweek, {{stop}}) = 0
                then 1
            else 0 end
    -- Take account of the scenario of incomplete weeks where the start day is a Sunday,
    -- and the stop day is not.
        + case
            when
                date_part(dayofweek, {{start}}) = 0 and
                date_part(dayofweek, {{stop}}) != 0
                then 1
            else 0 end
    )
)
{%- endmacro -%}
