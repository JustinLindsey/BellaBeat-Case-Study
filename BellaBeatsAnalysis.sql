-- checking weight vs bmi
SELECT distinct id, avg(weight_lbs), avg(bmi)
FROM WeightLog
group by id;

-- 1. how much time people spend in bed vs how often they are actually asleep
SELECT id, minutes_asleep / 60 AS time_asleep, time_in_bed / 60 as time_in_bed
FROM SleepDays;

-- 2. looking at total calories lost depending on the different types of active level
SELECT 
	distinct id, 
    round(sum(very_active_distance),2) as very_active, 
    round(sum(moderately_active_distance),2) moderately_active, 
    round(sum(light_active_distance),2) light_active,
    sum(calories) as total_calories
FROM DailyActivity da
GROUP BY id;

-- 3. tracking total_steps vs total_calories burned
SELECT distinct da.id, sum(da.total_steps) as total_steps, sum(dc.calories) as total_calories
FROM DailyActivity da 
LEFT JOIN DailyCalories dc 
	ON da.id = dc.id
GROUP BY da.id
ORDER BY total_steps desc;

-- making sure the calories are consistent across the tables for querying
select da.id, sum(da.calories), sum(dc.calories)
from dailyactivity da join dailycalories dc
on da.id = dc.id
group by da.id;

-- checking the different day of the week vs the total steps taken on that day
SELECT weekday(dates) as day_of_week, 
	CASE
		WHEN weekday(dates) = 0 THEN 'Monday'
		WHEN weekday(dates) = 1 THEN 'Tuesday'
		WHEN weekday(dates) = 2 THEN 'Wednesday'
		WHEN weekday(dates) = 3 THEN 'Thursday'
		WHEN weekday(dates) = 4 THEN 'Friday'
		WHEN weekday(dates) = 5 THEN 'Saturday'
		WHEN weekday(dates) = 6 THEN 'Sunday'
		ELSE weekday(dates) END AS new_day_of_week,
	sum(total_steps) as total_steps
FROM DailyActivity
GROUP BY day_of_week, new_day_of_week
ORDER BY day_of_week asc;

-- checking the amount of calories burned vs the day of the week
SELECT weekday(dates) as day_of_week, 
	CASE
		WHEN weekday(dates) = 0 THEN 'Monday'
		WHEN weekday(dates) = 1 THEN 'Tuesday'
		WHEN weekday(dates) = 2 THEN 'Wednesday'
		WHEN weekday(dates) = 3 THEN 'Thursday'
		WHEN weekday(dates) = 4 THEN 'Friday'
		WHEN weekday(dates) = 5 THEN 'Saturday'
		WHEN weekday(dates) = 6 THEN 'Sunday'
		ELSE weekday(dates) END AS new_day_of_week,
	sum(calories) as total_calories
FROM DailyActivity
GROUP BY day_of_week, new_day_of_week
ORDER BY day_of_week asc;

-- 4. combining the past 2 queries to later visualize calories vs day of week vs total_steps
SELECT weekday(dates) as day_of_week, 
	CASE
		WHEN weekday(dates) = 0 THEN 'Monday'
		WHEN weekday(dates) = 1 THEN 'Tuesday'
		WHEN weekday(dates) = 2 THEN 'Wednesday'
		WHEN weekday(dates) = 3 THEN 'Thursday'
		WHEN weekday(dates) = 4 THEN 'Friday'
		WHEN weekday(dates) = 5 THEN 'Saturday'
		WHEN weekday(dates) = 6 THEN 'Sunday'
		ELSE weekday(dates) END AS new_day_of_week,
	sum(calories) as total_calories,
    sum(total_steps) as total_steps
FROM DailyActivity
GROUP BY day_of_week, new_day_of_week
ORDER BY day_of_week asc;

-- 5. checking the sedentary minutes vs total steps and amount of calories burned
SELECT distinct id, sum(sedentary_minutes) as sedentary_minutes, sum(total_steps) as total_steps, sum(calories) as calories
FROM DailyActivity
GROUP BY id;

-- bmi level vs manual_reports
select distinct id as ids, count(*)
from weightlog
group by ids










