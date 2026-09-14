-- Question: How long does it typically take for a permit to go from filed to issued? Changes over time? 
-- Calculate the number of days between file_date_clean and issued_date_clean, then average by year. Exclude pre 1980 and 2026 data

SELECT 
	EXTRACT(YEAR FROM filed_date_clean) AS filed_year, AVG(EXTRACT(EPOCH FROM (issued_date_clean - filed_date_clean)) / 86400) AS avg_day
FROM "Building_Permits_20260911"
WHERE filed_date_clean IS NOT NULL
	AND issued_date_clean IS NOT NULL
	AND EXTRACT(YEAR FROM filed_date_clean) >= 1980 
	AND EXTRACT(YEAR FROM filed_date_clean) < 2026
GROUP BY EXTRACT(YEAR FROM filed_date_clean)
ORDER BY filed_year;
