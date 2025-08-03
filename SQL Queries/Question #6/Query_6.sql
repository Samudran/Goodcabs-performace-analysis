WITH cte1 AS (
    SELECT city_id, DATE_FORMAT(month, '%M %Y') AS month_name,
        SUM(total_passengers) AS total_passengers,
        SUM(repeat_passengers) AS repeat_passengers,
        ROUND((SUM(repeat_passengers) / SUM(total_passengers)) * 100, 2) AS repeat_passenger_rate
    FROM fact_passenger_summary
    GROUP BY city_id, month
),
cte2 AS (
    SELECT city_id,
        SUM(total_passengers) AS total_passengers,
        SUM(repeat_passengers) AS repeat_passengers,
        ROUND((SUM(repeat_passengers) / SUM(total_passengers)) * 100, 2) AS repeat_passenger_rate_city
    FROM fact_passenger_summary
    GROUP BY city_id
)

SELECT c.city_name, a.month_name, a.total_passengers, a.repeat_passengers,
    a.repeat_passenger_rate, b.repeat_passenger_rate_city
FROM cte1 a
JOIN cte2 b ON a.city_id = b.city_id
JOIN dim_city c ON a.city_id = c.city_id
ORDER BY c.city_name;
