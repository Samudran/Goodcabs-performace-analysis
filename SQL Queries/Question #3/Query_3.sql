SELECT city_name,
ROUND((SUM(CASE WHEN trip_count = '2-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "2-trips",
ROUND((SUM(CASE WHEN trip_count = '3-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "3-trips",
ROUND((SUM(CASE WHEN trip_count = '4-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "4-trips",
ROUND((SUM(CASE WHEN trip_count = '5-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "5-trips",
ROUND((SUM(CASE WHEN trip_count = '6-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "6-trips",
ROUND((SUM(CASE WHEN trip_count = '7-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "7-trips",
ROUND((SUM(CASE WHEN trip_count = '8-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "8-trips",
ROUND((SUM(CASE WHEN trip_count = '9-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "9-trips",
ROUND((SUM(CASE WHEN trip_count = '10-trips' THEN repeat_passenger_count ELSE 0 END) * 100) / NULLIF(SUM(repeat_passenger_count), 0), 2) AS "10-trips"
FROM dim_repeat_trip_distribution
JOIN dim_city USING (city_id)
GROUP BY city_name
ORDER BY city_name;
