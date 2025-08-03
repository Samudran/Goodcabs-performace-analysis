WITH cte1 AS (
    SELECT city_id, MONTHNAME(date) AS month_name, SUM(fare_amount) AS revenue, 
    RANK() OVER (PARTITION BY city_id ORDER BY SUM(fare_amount) DESC) AS rank_month
    FROM fact_trips
    GROUP BY city_id, MONTHNAME(date)
),

cte2 AS (
    SELECT city_id, SUM(fare_amount) AS total_revenue
    FROM fact_trips
    GROUP BY city_id
),

cte3 AS (
    SELECT city_name, a.city_id, a.month_name, a.revenue, rank_month, b.total_revenue
    FROM cte1 a
    JOIN cte2 b ON a.city_id = b.city_id
    JOIN dim_city c ON a.city_id = c.city_id
    WHERE rank_month = 1
)

SELECT city_name, month_name, revenue, ROUND((revenue / total_revenue) * 100, 2) AS pct_contribution
FROM cte3
ORDER BY city_name;
