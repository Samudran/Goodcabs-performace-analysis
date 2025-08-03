SELECT city_name, COUNT(trip_id) AS total_trip, 
ROUND(AVG(fare_amount / distance_travelled_km), 2) AS avg_fare_per_km,
ROUND(AVG(fare_amount), 2) AS avg_fare_per_trip,
ROUND(100.0 * COUNT(trip_id) / SUM(COUNT(trip_id)) OVER (), 2) AS percent_contribution
FROM fact_trips
JOIN dim_city USING (city_id)
GROUP BY city_name
ORDER BY total_trip DESC;
