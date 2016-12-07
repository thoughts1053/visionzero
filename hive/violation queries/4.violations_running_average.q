-- Working for all records all together. Need to break up between different boroughs

use vision_zero;
DROP TABLE IF EXISTS violations_running_average;

create table violations_running_average AS
 
SELECT
    year,
    borough,
	month,
	number_of_violations,
    round(avg(number_of_violations) over w3, 2) as 3mo_violations,
    round(avg(number_of_violations) over w6, 2) as 6mo_violations,
    round(avg(number_of_violations) over w12, 2) as 12mo_violations
from 
violations_per_borough_by_month group by borough,year, month, number_of_violations
order by borough, year, month
WINDOW
w3 AS (
    ORDER BY borough, year, month
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
),
w6 AS (
    ORDER BY borough, year, month
    ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
),
w12 AS (
    ORDER BY borough, year, month
    ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
);