----------------------DATA CLEANING (Delete Multiple Records)

select * from all_olympic_medalists


-- Chekc null values
select season from all_olympic_medalists
where season is null;


-- Check null values 
select medal from all_olympic_medalists
where medal is null


-- Delete null medal records 
Delete from all_olympic_medalists 
where medal is null;


-- Delete null athletes records 
Delete from all_olympic_medalists
where athletes is null;


-- Delete (?) not name althlets 
select distinct(athletes) from all_olympic_medalists

Delete from all_olympic_medalists
where athletes like '?%'


-- Capatlise athletes first latters in Original form 
use Olympic_Medalist_1896_2024
UPDATE all_olympic_medalists
SET athletes = UPPER(LEFT(athletes, 1)) + LOWER(SUBSTRING(athletes, 2, LEN(athletes)));


-- Remove 's' from the event_gender in men's  
UPDATE all_olympic_medalists
SET event_gender = LEFT(event_gender, LEN(event_gender) - 1)
WHERE event_gender = 'Men''s';


-- Remove 's' from the event_gender in women's
UPDATE all_olympic_medalists
SET event_gender = LEFT(event_gender, LEN(event_gender) - 1)
WHERE event_gender = 'Women''s';


-- Remove (') from the Women
UPDATE all_olympic_medalists
SET event_gender = REPLACE(event_gender, 'Women''', 'Women')
WHERE event_gender = 'Women''';


-- Remove (') from the Men
Update all_olympic_medalists
set event_gender = replace(event_gender, 'Men''','Men')
where event_gender = 'Men''';



USE Olympic_Medalist_1896_2024
SELECT * FROM all_olympic_medalists