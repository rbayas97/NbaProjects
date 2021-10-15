--Query showing number of players under the Age of 24 on each team 
SELECT TEAM, COUNT([FULL NAME]) AS '# Of players under the age of 24'
FROM [NBA PROJECT]..['Season2020-2021$']
WHERE AGE <= 24
GROUP BY TEAM;


--Query showing the team average age of players with at least 20 minutes played per game
SELECT TEAM, ROUND(AVG(['Season2020-2021$'].AGE),2)
FROM [NBA PROJECT]..['Season2020-2021$']
WHERE MPG >= 20
GROUP BY TEAM
ORDER BY ROUND(AVG(['Season2020-2021$'].AGE),2) ASC;


-- Query showing the Percentage change of Points Per Game from '19-20' Season to '20-21' Season
SELECT S21.[FULL NAME],
S21.TEAM,
S21.AGE,
S20.[PPGPointsPoints per game#] AS '2019-2020 PPG',
S21.[PPGPointsPoints per game#] AS '2020-2021 PPG',
ROUND(((S21.[PPGPointsPoints per game#]-S20.[PPGPointsPoints per game#])/NULLIF(S20.[PPGPointsPoints per game#],0))*100,2) AS SCORING_PERCENTAGE_CHANGE,
S20.[VIVersatility IndexVersatility index is a metric that measures a] AS '2019-2020 Versatility Index',
S21.[VIVersatility IndexVersatility index is a metric that measures a] AS '2020-2021 Versatility Index',
ROUND(((S21.[VIVersatility IndexVersatility index is a metric that measures a] - S20.[VIVersatility IndexVersatility index is a metric that measures a])/NULLIF(S20.[VIVersatility IndexVersatility index is a metric that measures a],0))*100,2) AS VI_PC
FROM [NBA PROJECT]..['Season2020-2021$'] S21
LEFT JOIN [NBA PROJECT]..['Season2019-2020$'] S20
	ON S21.[FULL NAME] = S20.[FULL NAME]
WHERE S21.AGE < 23 AND S21.[PPGPointsPoints per game#] > 12
ORDER BY VI_PC DESC;


-- Query showing top scorer on each team under the age of 24
WITH previous_query AS ( 
	SELECT S21.TEAM, 
	ROUND(MAX(S21.[PPGPointsPoints per game#]),2) AS HIGEST_PLAYER_AVG
	FROM [NBA PROJECT]..['Season2020-2021$'] AS S21
	WHERE AGE < 24
	GROUP BY S21.TEAM)
SELECT [NBA PROJECT]..['Season2020-2021$'].TEAM, AGE, [FULL NAME], [PPGPointsPoints per game#] AS HIGHEST_PLAYER_AVERAGE
FROM [NBA PROJECT]..['Season2020-2021$']
JOIN previous_query 
ON previous_query.TEAM = [NBA PROJECT]..['Season2020-2021$'].TEAM
AND previous_query.HIGEST_PLAYER_AVG = ['Season2020-2021$'].[PPGPointsPoints per game#];

-- Query Showing top NBA Scorer PPG 
SELECT TEAM, [FULL NAME], [PPGPointsPoints per game#], AGE
FROM [NBA PROJECT]..['Season2020-2021$']
WHERE [PPGPointsPoints per game#] = (
	SELECT MAX([NBA PROJECT]..['Season2020-2021$'].[PPGPointsPoints per game#]);
	
	
	
	
