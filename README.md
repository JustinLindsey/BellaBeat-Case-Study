# BellaBeat-Case-Study

#### ***[Data Source](https://www.kaggle.com/datasets/arashnic/fitbit)***

## **Introduction**
In this Case Study, I am a hypothetical Junior Analyst at a company called ***BellaBeat***. BellaBeat is a high-tech manufacturer of health-focused products for women. The Chief Creative Officer, Urška Sršen, believes that new growth opportunities for the company can come from analyzing device fitness data. My job in this case study will be to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices.

## **Ask**
### ***Identify the business task***
The business task in this study will be to analyze smart device usage to gain insight on how consumers use non-BellaBeat smart devices. Using that analysis, I will come up with recommendations for how this information can help BellaBeat marketing strategies.

### ***Identify Stakeholders***
The stakeholders will be 
* Urška Sršen: Bellabeat’s cofounder and Chief Creative Officer
* Sando Mur: Mathematician and Bellabeat’s cofounder; key member of the Bellabeat executive team
* Bellabeat marketing analytics team

### ***Products***
* Bellabeat app: The Bellabeat app provides users with health data related to their activity, sleep, stress, menstrual cycle, and mindfulness habits. This data can help users better understand their current habits and make healthy decisions. The Bellabeat app connects to their line of smart wellness products.

* Leaf: Bellabeat’s classic wellness tracker can be worn as a bracelet, necklace, or clip. The Leaf tracker connects to the Bellabeat app to track activity, sleep, and stress.

* Time: This wellness watch combines the timeless look of a classic timepiece with smart technology to track user activity, sleep, and stress. The Time watch connects to the Bellabeat app to provide you with insights into your
daily wellness.

* Spring: This is a water bottle that tracks daily water intake using smart technology to ensure that you are appropriately hydrated throughout the day. The Spring bottle connects to the Bellabeat app to track your hydration levels.

* Bellabeat membership: Bellabeat also offers a subscription-based membership program for users. Membership gives users 24/7 access to fully personalized guidance on nutrition, activity, sleep, health and beauty, and mindfulness based on their lifestyle and goals.

## **Prepare**
### ***Downloading data and storing it appropriately***
[FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit) (CC0: Public Domain, dataset made available through ([Mobius](https://www.kaggle.com/arashnic)): This Kaggle data set contains personal fitness tracker from thirty fitbit users. Thirty eligible Fitbit users consented to the submission of personal tracker data, including minute-level output for physical activity, heart rate, and sleep monitoring. It includes information about daily activity, steps, and heart rate that can be used to explore users’ habits.

### ***Organization and Credibility***
The dataset has 18 seperate CSV (Comma Seperated Value) files. The datasets contain information from thirty fitbit users who gave permission to track a variety of things including steps, heart rate, etc. The data dates from March, to May of 2016 so it is slightly outdated, though it can still be useful. Because it was collected through a third party and the respondants only total to 30, it is not extremely reliable data, but I will still perform analysis.

### ***Data used***
Bellabeats success is dependent on understanding how its consumers use certain devices. Our data only comes from 30 individual users, so it is crucial to try to eliminate other factors that are not reliable. Instead of focusing on passive data, I will focus on directly input logged data. 

From the 18 different CSV files available, I have selected five to focus on seeing as a lot of them were redundant.
* dailyActivity_merged.csv
* dailyCalories_merged.csv
* dailyIntensities_merged.csv
* weightLogInfo_merged.csv
* sleepDay_merged.csv
 
## Process
### ***Tools for the study***
The tools that I chose to use during this case study included **MySQL Workbench, Excel, and Tableau.** SQL for easy analysis and Tableau for visualizations of my findings.

### ***Transforming the data and checking for errors***
I began by opening the five CSV files I chose in Excel. With using MySQL Workbench, I know that empty cells do not automatically convert to NULL values so I manually put those in before moving the files to SQL. I also changed the formatting of the dates column from 'mm-dd-yy' to ''yyyy-mm-dd hh:mm:ss' to stay consistent and make the converting of datatypes easier. The last thing I did in excel was change the titles of the columns for efficiency with writing my queries.

After the cleaning in Excel, it is time to do a bit of validation and cleaning in SQL. For the full cleaning script click [here](https://github.com/JustinLindsey/BellaBeat-Case-Study/blob/main/BellaBeatsCleaning.sql). I began by going through each of the tables and converting the 'dates' column to DATETIME datatype.
```
-- DONE FOR EVERY TABLE
SELECT *
FROM SleepDays 
LIMIT 25;
-- Changing the datatype of the 'dates' column' to DATETIME
ALTER TABLE SleepDays
MODIFY dates DATETIME;
```
Then I ran a query for the 'id' column. It is seen throughout each of the tables so I wanted to make sure it the length was accurate across all of them

``` -- DONE FOR EVERY TABLE
SELECT count(*), length(id) as len
FROM DailyIntensity 
WHERE length(id) = 10
GROUP BY len;
```
Next I checked the amount of distinct users per table
```
SELECT count(distinct id)
FROM DailyIntensity; 
```
The result showed that there were a different amount of unique id's.
* DailyActivity,DailyCalories,DailyIntensity = 33
* SleepDay = 24
* WeightLog = 8

These are inconsistent but this query confirms that it is due to the users not using that product with NULL values
```
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
```
## **Analyze and Share**

The first visualization shows relationship between activity level, and the amount of calories burned. Ultimately it was established that their is no significant correlation between the level and how many calories burned.
```
SELECT 
	distinct id, 
    round(sum(very_active_distance),2) as very_active, 
    round(sum(moderately_active_distance),2) moderately_active, 
    round(sum(light_active_distance),2) light_active,
    sum(calories) as total_calories
FROM DailyActivity da
GROUP BY id;
```
![Screen Shot 2022-09-29 at 5 01 35 PM](https://user-images.githubusercontent.com/99827985/193150070-62b7644b-a4a2-419c-a1ac-25abcedb4720.png)


The next query and visualization details the calories burned vs the amount of steps the user took. We see a very clear trendline which is expected.
```
SELECT distinct da.id, sum(da.total_steps) as total_steps, sum(dc.calories) as total_calories
FROM DailyActivity da 
LEFT JOIN DailyCalories dc 
	ON da.id = dc.id
GROUP BY da.id
ORDER BY total_steps desc;
```
![Screen Shot 2022-09-29 at 4 53 43 PM](https://user-images.githubusercontent.com/99827985/193149026-3fc0a803-c2e9-4441-9fef-cbd9c8256de9.png)


I then viewed how people approached different days of the week. Looking to see how many steps were take and calories were burned depending on the day. The data is very consistent. On days that people take more steps, they also burn more calories.
```
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
```
![Screen Shot 2022-09-29 at 4 54 54 PM](https://user-images.githubusercontent.com/99827985/193149231-a25d4f41-2dbc-46fa-8bb2-d5270d59dcf7.png)


The last query and viz is about the steps vs calories burned. The difference is that I factored in how mny sedentary minutes took place as well to see if this impacted the calories burned. The data shows that there was not much correlation.
```
SELECT distinct id, sum(sedentary_minutes) as sedentary_minutes, sum(total_steps) as total_steps, sum(calories) as calories
FROM DailyActivity
GROUP BY id;
```
![Screen Shot 2022-09-29 at 4 56 34 PM](https://user-images.githubusercontent.com/99827985/193149415-d917025f-2341-48b2-b96d-5acbfcf9ec60.png)



