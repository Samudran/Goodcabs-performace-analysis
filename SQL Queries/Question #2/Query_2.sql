WITH actual AS (
    SELECT MONTHNAME(date) AS month_name, city_id, COUNT(trip_id) AS actual_trips
    FROM fact_trips
    GROUP BY MONTHNAME(date), city_id
),
target AS (
    SELECT MONTHNAME(month) AS month_name, city_id, total_target_trips AS target_trips
    FROM targets_db.monthly_target_trips
)

SELECT c.city_name, a.month_name, a.actual_trips, t.target_trips,
CASE
    WHEN a.actual_trips > t.target_trips THEN 'Above Target'
    ELSE 'Below Target'
END AS performance_status,
ROUND(((a.actual_trips - t.target_trips) * 100.0) / t.target_trips, 2) AS percent_difference
FROM actual a
JOIN target t ON a.city_id = t.city_id AND a.month_name = t.month_name
JOIN dim_city c ON a.city_id = c.city_id
ORDER BY city_name, month_name;
