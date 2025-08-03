(SELECT city_name, SUM(new_passengers) AS new_passengers, 'Top 3' AS city_category 
FROM trips_db.fact_passenger_summary
JOIN dim_city USING (city_id)
GROUP BY city_name
ORDER BY SUM(new_passengers) DESC
LIMIT 3)

UNION

(SELECT city_name, SUM(new_passengers) AS new_passengers, 'Bottom 3' AS city_category 
FROM trips_db.fact_passenger_summary
JOIN dim_city USING (city_id)
GROUP BY city_name
ORDER BY SUM(new_passengers) ASC
LIMIT 3);
