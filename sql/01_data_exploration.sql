-- How many total rows
SELECT COUNT(*) FROM "Building_Permits_20260911";

-- How many are missing a completed date? 
SELECT COUNT(*) FROM "Building_Permits_20260911" WHERE "Completed Date" IS NULL OR "Completed Date" = '';

-- How many are missing an issue date? 
SELECT COUNT(*) FROM "Building_Permits_20260911" WHERE "Issued Date" IS NULL OR "Issued Date" = '';

-- Rows where Issued Date comes before Filed Date -- Logically impossible 
SELECT COUNT(*) FROM "Building_Permits_20260911" WHERE "Issued Date" < "Filed Date";

-- Check data structure

SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'Building_Permits_20260911' AND column_name IN ('Filed Date', 'Issued Date', 'Completed Date');

-- Date Conversion check 

SELECT "Filed Date",
	TO_TIMESTAMP("Filed Date", 'YYYY/MM/DD HH12:MI:SS AM') AS filed_date_converted 
FROM "Building_Permits_20260911"
LIMIT 10;

-- Add new timestamped columns 

ALTER TABLE "Building_Permits_20260911" ADD COLUMN filed_date_clean TIMESTAMP;

ALTER TABLE "Building_Permits_20260911" ADD COLUMN issued_date_clean TIMESTAMP;

ALTER TABLE "Building_Permits_20260911" ADD COLUMN completed_date_clean TIMESTAMP;

-- Populate new columns with converted timestamps

UPDATE "Building_Permits_20260911" 
SET filed_date_clean = TO_TIMESTAMP("Filed Date", 'YYYY/MM/DD HH12:MI:SS AM')
WHERE "Filed Date" IS NOT NULL AND "Filed Date" != '';

UPDATE "Building_Permits_20260911" 
SET issued_date_clean = TO_TIMESTAMP("Issued Date", 'YYYY/MM/DD HH12:MI:SS AM')
WHERE "Issued Date" IS NOT NULL AND "Issued Date" != '';

UPDATE "Building_Permits_20260911" 
SET completed_date_clean = TO_TIMESTAMP("Completed Date", 'YYYY/MM/DD HH12:MI:SS AM')
WHERE "Completed Date" IS NOT NULL AND "Completed Date" != '';

SELECT *
FROM "Building_Permits_20260911" 
LIMIT 10;

-- Data check: Issued Date after Filed Date using new cleaned columns 

SELECT COUNT(*) FROM "Building_Permits_20260911"
WHERE issued_date_clean < filed_date_clean; 

-- 2,292 rows where issues_date_clean < filed_date_clean 
-- Check for discrepencies 
-- Older records, exclude these rows from approval time analysis 

SELECT "Filed Date", filed_date_clean, "Issued Date", issued_date_clean
FROM "Building_Permits_20260911"
WHERE issued_date_clean < filed_date_clean
LIMIT 10;

-- Future queries to contain WHERE issued_date_clean >= filed_date_clean
