--------------------CHALANGES

select * from all_olympic_medalists





--1. Count Medals by Country
select country, count(medal) as 'Total_count_winning' from all_olympic_medalists
group by country
order by Total_count_winning desc;



--2. Top 5 Athletes by Medal Count 
select top(5) athletes, count(medal) as 'No_of_medals' from all_olympic_medalists
group by athletes
order by No_of_medals desc;



--3. Count medals by year
select year, count(medal) as 'Total_medals' from all_olympic_medalists
group by year
order by year asc;



--4. Count medals by country in year asc order & take only 20th century 
select year, country, count(athletes) as 'total_no_of_athletes' from all_olympic_medalists
where year >=2000
group by  year, country 
order by year asc, country asc



--5. Host country with total_games_host dec order  
select country, count(games) as 'Total_games_host' from all_olympic_medalists
group by country
order by Total_games_host desc;



--6. For each sport, count how many different events there are for Men, Women, and Mixed categories. Only show sports that have events in all three genders. Sort the results by sport name.
select sport, event_gender,
row_number()
over 
(partition by sport order by event_gender asc) as 'Ranking',
count(medal) as 'no_of_games'
from all_olympic_medalists
where event_gender in ('men' , 'women' , 'mixed')
and 
sport in
( select sport from all_olympic_medalists 
where event_gender in ('Men','Women','Mixed')
group by sport
having count(distinct event_gender) = 3)
group by sport, event_gender



--7. Write a SQL query to rank countries within each Olympic year based on their participation. For each year and country, count the total number of medals won and assign a row number that resets for each year. Display the year, country, total medal count, and rank. Sort the final result by year (ascending) and medal count (descending).
select 
year, 
country, 
count(medal) as 'Total_winning_medal_in_percentage',
row_number()
over 
(partition by year order by year asc) as 'ranks'
from all_olympic_medalists
group by year, country
order by year asc, Total_winning_medal_in_percentage desc;



--8. Write a SQL query to find the number of gold medals won by each country in each Olympic year. For each country, assign a row number to each year based on chronological order. Display the country, year, number of gold medals, and the rank of each year for that country.
select country, year, count(medal)as 'No_of_gold_medal',
row_number() 
over 
(partition by country order by year asc) as 'ranks' 
from all_olympic_medalists
where medal = 'gold'
group by year, country;



--9. Write a SQL query to rank the top 3 athletes per sport based on total medals won. Use a window function to assign ranks. Include sport, athletes, total_medals, rank.
with athletes_records as (
select sport,
athletes,
count(medal) as Total_medals,
ROW_NUMBER() 
over 
(partition by sport 
order by count(medal) desc ) as 'ranks'
from all_olympic_medalists
group by sport, athletes) 
select 
sport, 
athletes,
Total_medals,
ranks
from athletes_records 
where ranks < 4;



--10. Write a SQL query to list all countries that have won  zero gold medals in Winter Olympics. Include the total non-gold medals they won.
select 
country, season, count(medal) as 'Count_silver_&_bronze'
from all_olympic_medalists
where medal in ('Bronze','Silver') 
and 
season = 'winter'
group by country,season
order by [Count_silver_&_bronze] asc;



--11. Write a SQL query to find sports where one country has won more than 50% of all gold medals in that sport across all Olympics. Display sport, dominant_country, gold_by_country, total_gold_in_sport, percentage.
Use two levels of aggregation: First, total gold per sport (subquery). Second, gold per country per sport. Join them, calculate (gold_by_country * 100.0 / total_gold_in_sport) > 50, and filter accordingly. Use ROUND for percentage.



--12. Write a SQL query to find the number of unique events (distinct event_name) per sport, broken down by event_gender (Men's, Women's, Mixed). Include only sports with events in all three genders. Order by sport.



--13. Count total no of medal in gold, bornze, silver 
select medal, count(medal) as 'Total_Medals' from all_olympic_medalists
group by medal
order by medal desc



--14. Write a SQL query to rank Olympic medal counts by year and country, using  ROW_NUMBER() and grouped totals by sport and gender. 
select
year,
ROW_NUMBER()
over 
(partition by year order by year asc) as 'Year_Ranking',
country_code, 
ROW_NUMBER() 
over 
(partition by country_code order by sport asc) as 'Country_code_Ranking',
sport,
event_gender, count(medal) [Total_medal]
from all_olympic_medalists
group by year, country_code, sport, event_gender
order by year asc, country_code asc, sport asc, event_gender asc, Total_medal asc