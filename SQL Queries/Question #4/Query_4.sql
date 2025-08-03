WITH ranks AS (
    SELECT city_name, SUM(new_passengers) AS new_passengers,
    RANK() OVER (ORDER BY SUM(new_passengers) DESC) AS rank_desc,
    RANK() OVER (ORDER BY SUM(new_passengers) ASC) AS rank_asc
    FROM trips_db.fact_passenger_summary
    JOIN dim_city USING (city_id)
    GROUP BY city_name
    ORDER BY SUM(new_passengers) ASC
)

SELECT city_name, new_passengers,
CASE
    WHEN rank_asc <= 3 THEN 'Bottom 3'
    WHEN rank_desc <= 3 THEN 'Top 3'
    ELSE NULL
END AS city_category
FROM ranks
WHERE rank_desc <= 3 OR rank_asc <= 3
ORDER BY new_passengers DESC;
