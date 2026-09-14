-- Question: How has the volume of building permits filed in San Francisco changed year over year? 
-- Establish basic landscape of data overtime 
-- After first pass, exclude pre-1980 data and incomplete 2026 data

SELECT EXTRACT(YEAR FROM filed_date_clean) AS filed_year, COUNT(*) AS permit_count
FROM "Building_Permits_20260911"
WHERE filed_date_clean IS NOT NULL
	AND EXTRACT(YEAR FROM filed_date_clean) >= 1980
	AND EXTRACT(YEAR FROM filed_date_clean) < 2026
GROUP BY EXTRACT(YEAR FROM filed_date_clean)
ORDER BY filed_year;