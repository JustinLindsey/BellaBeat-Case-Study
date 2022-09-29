/* ---- Checking SleepDays Table ----*/
SELECT *
FROM SleepDays
LIMIT 25;
-- Changing the datatype of the 'dates' column' to DATETIME
ALTER TABLE SleepDays
MODIFY dates DATETIME;

/* ---- Checking WeightLog Table ---- */
SELECT *
FROM WeightLog;
-- Changing the datatype of the 'dates' column' to DATETIME
ALTER TABLE WeightLog
MODIFY dates DATETIME;

/* ---- Checking DailyCalories Table ---- */
SELECT *
FROM DailyCalories
LIMIT 25;
-- Changing the datatype of the 'dates' column' to DATETIME
ALTER TABLE DailyCalories
MODIFY dates DATETIME;

/* ---- Checking DailyActivity Table ---- */
SELECT *
FROM DailyActivity
LIMIT 25;
-- Changing the datatype of the 'dates' column' to DATETIME
ALTER TABLE DailyActivity
MODIFY dates DATETIME;

/* ---- Checking DailyIntensity Table ---- */
SELECT *
FROM DailyIntensity
LIMIT 25;
-- Changing the datatype of the 'dates' column' to DATETIME
ALTER TABLE DailyIntensity
MODIFY dates DATETIME;

/* --------------------------------------- */
-- checking length of id
SELECT count(*), length(id) as len
FROM DailyIntensity 
WHERE length(id) = 10
GROUP BY len;
-- checking length of id
SELECT count(*), length(id) as len
FROM DailyActivity
WHERE length(id) = 10
GROUP BY len;
-- checking length of id
SELECT count(*), length(id) as len
FROM DailyCalories
WHERE length(id) = 10
GROUP BY len;
-- checking length of id
SELECT count(*), length(id) as len
FROM SleepDays
WHERE length(id) = 10
GROUP BY len;
-- checking length of id
SELECT count(*), length(id) as len
FROM WeightLog
WHERE length(id) = 10
GROUP BY len;

-- checking number of distinct users per tables
SELECT count(distinct id)
FROM DailyIntensity; 
-- checking number of distinct users per tables
SELECT count(distinct id)
FROM DailyActivity; 
-- checking number of distinct users per tables
SELECT count(distinct id)
FROM DailyCalories; 
-- checking number of distinct users per tables
SELECT count(distinct id)
FROM SleepDays; 
-- checking number of distinct users per tables
SELECT count(distinct id)
FROM WeightLog; 

-- Joining the tables to verify that the unique id's were consistent across all of them
SELECT 
	da.id, -- DailyActivity table will be used as the basis
	AVG(da.total_distance) AS total_distance,
	AVG(da.logged_activities_distance) AS logged_activity, 
    AVG(da.calories) AS calories, 
    AVG(sd.minutes_asleep)/60 AS avg_sleep_hours, 
    AVG(wl.weight_lbs) AS avg_logged_weight
FROM DailyActivity AS da 
LEFT JOIN SleepDays AS sd 
	ON da.id = sd.id 
LEFT JOIN WeightLog AS wl 
	ON sd.id = wl.id 
GROUP BY da.id;








