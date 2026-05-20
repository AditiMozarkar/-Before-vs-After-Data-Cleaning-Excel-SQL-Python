-- View Raw Dataset

SELECT * FROM business_data;



-- Remove Extra Spaces from Client Names

SELECT
    TRIM(client) AS clean_client
FROM business_data;



-- Convert Client Names to Lowercase

SELECT
    LOWER(client) AS clean_client
FROM business_data;



-- Combine LOWER + TRIM

SELECT
    LOWER(TRIM(client)) AS clean_client
FROM business_data;



-- Check Duplicate Records

SELECT
    client,
    COUNT(*) AS total_records
FROM business_data
GROUP BY client
HAVING COUNT(*) > 1;



-- Remove Duplicate Rows

SELECT DISTINCT *
FROM business_data;



-- Replace #DIV/0! Errors with NULL

SELECT
    CASE
        WHEN profit_margin = '#DIV/0!' THEN NULL
        ELSE profit_margin
    END AS clean_profit_margin
FROM business_data;



-- Find Missing Revenue or Payment Values

SELECT *
FROM business_data
WHERE payment IS NULL
   OR revenue IS NULL;



-- Clean Contact Names

SELECT
    TRIM(contact) AS clean_contact
FROM business_data;



-- Split Department and City

SELECT
    SPLIT_PART(department, '_', 1) AS clean_department,
    SPLIT_PART(department, '_', 2) AS clean_city
FROM business_data;



-- Final Cleaned Dataset

SELECT DISTINCT

    date,

    INITCAP(
        TRIM(
            SPLIT_PART(client, '(', 1)
        )
    ) AS client,

    INITCAP(
        REGEXP_REPLACE(
            TRIM(contact),
            '\s+',
            ' ',
            'g'
        )
    ) AS contact,

    INITCAP(
        SPLIT_PART(department, '_', 1)
    ) AS department,

    INITCAP(
        SPLIT_PART(department, '_', 2)
    ) AS city,

    COALESCE(payment, 'NA') AS payment,

    COALESCE(revenue, 'NA') AS revenue,

    profit,

    CASE
        WHEN profit_margin = '#DIV/0!' THEN 'Null'
        ELSE profit_margin
    END AS profit_margin

FROM business_data

WHERE client IS NOT NULL

ORDER BY date;