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

After the cleaning in Excel, it is time to do a bit of validation and cleaning in SQL. For the full cleaning script click [Here](https://github.com/JustinLindsey/BellaBeat-Case-Study/blob/main/BellaBeatsCleaning.sql)
