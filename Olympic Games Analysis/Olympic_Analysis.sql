--Q1: How Many Olympic Games have been Held?
Select count(distinct(Games)) as Total_olympics_Games
FROM athlete_events;

--Q2: List down all olympic games so far
select DISTINCT Year, season, City
from athlete_events
order by Year;

--Q3: mention total no of nations who participated in each olympics game
With all_countries as(
	Select ae.games, nc. region
	from athlete_events ae
	Join noc_regions nc on ae.NOC = nc.NOC
	group by games, nc.region
)
Select games, count(1) as total_countries
	from all_countries
	group by games
	order by games;

--Q4: Which year saw the highest and lowest no of countries participating in olympics
With all_countries as(
	Select ae.games, nc. region
	from athlete_events ae
	Join noc_regions nc on ae.NOC = nc.NOC
	group by games, nc.region
),
 country_count AS (
	select games, count(*) as total_countries
	from all_countries
	group by games
)
select *
from country_count
where total_countries = (SELECT Max(total_countries) from country_count)
OR total_countries = (select min(total_countries) from country_count);


--Q5: Which nation has participated in all of the olympic games
With total_olympic_Games AS(
	select count (distinct games) As total_games
	from athlete_events
),
	All_countries AS(
		select ae.Games, ae.NOC, nocr.region as Country
		from athlete_events ae
		join noc_regions nocr on ae.NOC = nocr.NOC
		)
		
Select Country, count (distinct Games) as No_of_olympic_played
from All_countries
group by Country
Having count (distinct Games) = (select total_games from total_olympic_Games)
Order by country;


--Q6: Identify the sport which was played in all summer olympics.
With summer_olympics AS(
	select count(distinct Games) As tot_sum_games
	from athlete_events
	where Season = "Summer"
),
 Sport_Count AS(
	select Sport, count(distinct Games) As game_cnt
	from athlete_events
	where season = "Summer"
	group by sport
)
Select sc.sport, sc.game_cnt
from Sport_Count sc
where sc.game_cnt = (select tot_sum_games from summer_olympics)
order by sc.sport;

--Q7: Which Sports were just played only once in the olympics.
with sport_count AS(
	SELECT sport, count(distinct Games) As Games_count, Games
	from athlete_events
	group by Sport
)
select sport, Games_count as no_of_games, Games
from sport_count
where games_count = 1;

--Q8: Fetch the total no of sports played in each olympic games.
SELECT Games, count(distinct Sport) as no_of_sports
from athlete_events
group by games


--Q9  Fetch oldest athletes to win a gold medal
Select *
from athlete_events
where medal = "Gold" 
	AND Age != "NA"
	AND CAST (Age AS Unsigned) = (
		select max(cast(Age as Unsigned))
		from athlete_events
		where medal = "Gold" AND Age != "NA"
	);


--Q10: Find the Ratio of male and female athletes participated in all olympic games.
WITH gender_count AS (
    SELECT 
        SUM(CASE WHEN Sex = 'M' THEN 1 ELSE 0 END) AS male_count,
        SUM(CASE WHEN Sex = 'F' THEN 1 ELSE 0 END) AS female_count
    FROM athlete_events
)
SELECT 
    '1 : ' || ROUND(1.0 * male_count / female_count, 2) AS F_to_M_ratio
FROM gender_count;

--Q11: Fetch the top 5 athletes who have won the most gold medals.
With Gold_Medal AS(
select ID, Name, Team, count(Medal) As No_of_gold_Medals
from athlete_events
where Medal = "Gold"
Group by ID, Name, Team
),
Ranked_gold AS(
select *, 
dense_rank () over (order by No_of_gold_Medals DESC) As rnk
from Gold_Medal
)
Select ID, Name, Team, No_of_gold_Medals
from Ranked_gold
where rnk<=5
order by No_of_gold_Medals DESC, Name, Team;

--Q12: Fetch the top 5 athletes who have won the most medals (gold/silver/bronze)
With All_Medal AS(
select ID, Name, Team, count(Medal) As No_of_Medals
from athlete_events
where Medal In ("Gold", "Silver", "Bronze")
Group by ID, Name, Team
),
Ranked_medal AS(
select *, 
dense_rank () over (order by No_of_Medals DESC) As rnk
from All_Medal
)
Select ID, Name, Team, No_of_Medals
from Ranked_medal
where rnk<=5
order by No_of_Medals DESC, Name, Team;


--Q13: Fetch the top 5 most successful countries in olympics. Success is defined by no of medals
with Country_medals As (
Select nc.region, count(Medal) As medal_count
from athlete_events ae
join noc_regions nc on ae.NOC = nc.NOC
where Medal in ("Gold", "Silver", "Bronze")
group by nc.region
),
Country_rank AS(
select *,
dense_rank () over (order  by medal_count desc) As Rnk
from Country_medals
)
select * 
from Country_rank
where Rnk<=5


--Q14: List down total gold, silver and bronze medals won by each country.
Select nr.region,
sum( case when ae.medal = "Gold" then 1 else 0 end) As Gold_medals,
sum( case when ae.medal = "Silver" then 1 else 0 end) As Silver_medals,
sum( Case when ae.medal = "Bronze" then 1 else 0 end) As Bronze_medals
from athlete_events ae
join noc_regions nr on ae.NOC = nr.NOC
where ae.medal IN ("Gold","Silver","Bronze")
group by nr. region
order by Gold_medals DESC, Silver_medals Desc, Bronze_medals DESC;


--Q15: List down total gold, silver and bronze medals won by each country corresponding to each olympic games.
Select ae.games, nr.region, 
sum(case when ae.medal = "Gold" then 1 else 0 end) As Gold_medals,
sum(case when ae.medal = "Silver" then 1 else 0 end) As Silver_medals,
sum(case when ae.medal = "Bronze" then 1 else 0 end) As Bronze_medals
from athlete_events ae
join noc_regions nr on ae.NOC = nr.NOC
where ae.medal IN ("Gold","Silver","Bronze")
group by ae.games, nr.region
order by ae.games;

--Q16: Identify which country won the most gold, most silver and most bronze medals in each olympic games.
 With medal_tally As(
	SELECT 
        ae.Games,
        nr.region AS Country,
        ae.Medal,
        COUNT(*) AS Medal_Count
    FROM athlete_events ae
    JOIN noc_regions nr ON ae.NOC = nr.NOC
    WHERE ae.Medal IN ('Gold', 'Silver', 'Bronze')
    GROUP BY ae.Games, nr.region, ae.Medal
),
Gold_max As (
	select games, country ||' - '|| medal_count as max_gold
	from (
		select games, country, medal_count,
			Rank() over(partition by games order by medal_count desc) as rnk
		from medal_tally
		where medal = "Gold"
	)g
where rnk = 1
),
Silver_max As (
	select games, country ||' - '|| medal_count as max_silver
	from (
		select games, country, medal_count,
			Rank() over(partition by games order by medal_count desc) as rnk
		from medal_tally
		where medal = "Silver"
	)s
where rnk = 1
),
Bronze_max As (
	select games, country ||' - '|| medal_count as max_bronze
	from (
		select games, country, medal_count,
			Rank() over(partition by games order by medal_count desc) as rnk
		from medal_tally
		where medal = "Bronze"
	)b
where rnk = 1
)
SELECT 
    g.Games,
    g.max_gold,
    s.max_silver,
    b.max_bronze
FROM Gold_Max g
JOIN Silver_Max s ON g.Games = s.Games
JOIN Bronze_Max b ON g.Games = b.Games
ORDER BY g.Games;


--Q17: Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
With medal_tally As(
	SELECT 
        ae.Games,
        nr.region AS Country,
        ae.Medal,
        COUNT(*) AS medal_Count
    FROM athlete_events ae
    JOIN noc_regions nr ON ae.NOC = nr.NOC
    WHERE ae.Medal IN ('Gold', 'Silver', 'Bronze')
    GROUP BY ae.Games, nr.region, ae.Medal
),
Gold_max As (
	select games, country ||' - '|| medal_count as max_gold
	from (
		select games, country, medal_count,
			Rank() over(partition by games order by medal_count desc) as rnk
		from medal_tally
		where medal = "Gold"
	)g
where rnk = 1
),
Silver_max As (
	select games, country ||' - '|| medal_count as max_silver
	from (
		select games, country, medal_count,
			Rank() over(partition by games order by medal_count desc) as rnk
		from medal_tally
		where medal = "Silver"
	)s
where rnk = 1
),
Bronze_max As (
	select games, country ||' - '|| medal_count as max_bronze
	from (
		select games, country, medal_count,
			Rank() over(partition by games order by medal_count desc) as rnk
		from medal_tally
		where medal = "Bronze"
	)b
where rnk = 1
),
Max_medals As (
	select games, country ||' - '|| total_medals as max_total
	from (
	select games, country, sum(medal_count) AS total_medals,
		rank() over(partition by games order by sum(medal_count) desc) As Rnk
	from medal_tally
	group by games, country
	)t
where rnk = 1
)
SELECT 
    g.Games,
    g.max_gold,
    s.max_silver,
    b.max_bronze,
	t.max_total
FROM Gold_Max g
JOIN Silver_Max s ON g.Games = s.Games
JOIN Bronze_Max b ON g.Games = b.Games
JOIN Max_medals t ON g.Games = t.Games
ORDER BY g.Games;


--Q18: Which countries have never won gold medal but have won silver/bronze medals?
With Country_medals AS(
	Select nr.region,
	sum( case when ae.medal = "Gold" then 1 else 0 end) As Gold_medals,
	sum( case when ae.medal = "Silver" then 1 else 0 end) As Silver_medals,
	sum( Case when ae.medal = "Bronze" then 1 else 0 end) As Bronze_medals
	from athlete_events ae
	join noc_regions nr on ae.NOC = nr.NOC
	where ae.medal IN ("Gold","Silver","Bronze")
	group by nr. region
	order by Gold_medals DESC, Silver_medals Desc, Bronze_medals DESC
)
Select * from Country_medals
where Gold_medals = 0 AND (Silver_medals >=1 OR Bronze_medals>=1);


--Q19: In which Sport/event, India has won highest medals.
select ae.Sport, nr.region, count(Medal)
from athlete_events ae
join noc_regions nr on ae.NOC = nr.NOC
where nr.region = "India" AND Medal <>"NA"
group by ae.Sport
order by count(Medal) DESC
Limit 1;

--Q20:Break down all olympic games where India won medal for Hockey and how many medals in each olympic games
--with india_medals AS(
	select ae.Team as Team, ae.Sport, ae.games, count(Medal)
	from athlete_events ae
	where Team = "India" AND Sport = "Hockey" AND Medal <> "NA"
	group by games;
