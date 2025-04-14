SELECT 
  city, property_type,                --- We want to show results grouped by each city and property type
  AVG(bathrooms) AS avg_bathrooms,    --- compute the average number of bathrooms 
  AVG(bedrooms) AS avg_bedrooms       --- compute the average number of bedrooms
FROM 
  airbnb_search_details
GROUP BY 
  city, property_type;                --- Groups the data so averages are calculated for each (city, property_type) pair
