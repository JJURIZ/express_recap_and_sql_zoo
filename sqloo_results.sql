-- 0 SELECT basics
-- 1.
SELECT population 
FROM world
WHERE name = 'Germany'
-- 2.
SELECT name, population 
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');
-- 3.
SELECT name, area 
FROM world
WHERE area BETWEEN 200000 AND 250000


-- 1 SELECT name
-- 1.
SELECT name FROM world
WHERE name LIKE 'Y%'
-- 2.
SELECT name FROM world
WHERE name LIKE '%y'
-- 3.
SELECT name 
FROM world
WHERE name LIKE '%x%'
-- 4.
SELECT name 
FROM world
WHERE name LIKE '%land'
-- 5.
SELECT name 
FROM world
WHERE name LIKE 'C%' && 
      name LIKE '%ia'
-- 6.
SELECT name 
FROM world
WHERE name LIKE '%oo%'
-- 7.
SELECT name 
FROM world
WHERE name LIKE '%a%%a%%a%'
-- 8.
SELECT name 
FROM world
WHERE name LIKE '_t%'
ORDER BY name
-- 9.
SELECT name 
FROM world
WHERE name LIKE '%o__o%'
-- 10.
SELECT name 
FROM world
WHERE name LIKE '____'
-- 11.
SELECT name
FROM world
WHERE name LIKE capital
-- 12.
SELECT name
FROM world
WHERE capital LIKE concat(name,'_City')
-- 13, 14, and 15 have a bug, please skip them


-- 2 SELECT from World
-- 1.
SELECT name, continent, population FROM world
-- 2.
SELECT name FROM world
WHERE population >= 200000000
-- 3.
SELECT name, gdp/population
FROM world
WHERE population > 200000000
-- 4.
SELECT name, population/1000000
FROM world
WHERE continent = 'South America'
-- 5.
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy')
-- 6.
SELECT name
FROM world
WHERE name LIKE '%United%'
-- 7.
SELECT name, population, area
FROM world
WHERE area > '3000000' OR population > '250000000'
-- 8.
SELECT name, population, area
FROM world
WHERE area > '3000000' XOR population > '250000000'
-- 9.
SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2)
FROM world
WHERE continent = 'South America'
-- 10.
SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000
-- 11.
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital)
-- 12.
SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1) && name != capital
-- 13.
SELECT name
FROM world
WHERE name LIKE '%a%' &&
      name LIKE '%e%' &&
      name LIKE '%i%' &&
      name LIKE '%o%' &&
      name LIKE '%u%' &&
      name NOT LIKE '% %'

-- 3 SELECT from Nobel
-- 1.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950
-- 2.
SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'
-- 3.
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'
-- 4.
SELECT winner
FROM nobel
WHERE yr >= 2000 &&
      subject = 'Peace'
-- 5.
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature' &&
      yr BETWEEN 1980 AND 1989
-- 6.
SELECT * 
FROM nobel
WHERE subject = 'Peace'
AND winner IN ('Barack Obama', 'Theodore Roosevelt', 'Jimmy Carter', 'Woodrow Wilson')
-- 7.
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'
-- 8.
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Physics' && yr = 1980) OR
      (subject = 'Chemistry' && yr = 1984)
-- 9.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980 &&
      subject != 'Chemistry' &&
      subject != 'Medicine'
-- 10.
SELECT yr, subject, winner
FROM nobel
WHERE (yr < 1910 AND subject = 'Medicine') OR
      (yr >= 2004 AND subject = 'Literature')
-- 11.
SELECT yr, subject, winner
FROM nobel
WHERE winner = 'PETER GRÜNBERG'
-- 12.
SELECT yr, subject, winner
FROM nobel
WHERE winner = `'Eugene O\'Neill'` 
-- ADDED BACKTICKS TO EugeneO Neill - IF testing remove backticks first! 
-- 13.
SELECT winner, yr, subject
FROM nobel 
WHERE winner LIKE 'Sir%'
ORDER BY -yr, winner
-- 14.
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'), subject, winner


-- 4 SELECT within SELECT
-- 1.
SELECT name 
FROM world
WHERE population >
      (SELECT population FROM world
       WHERE name='Russia')
-- 2.
SELECT name
FROM world
WHERE gdp/population > 
          (SELECT gdp/population FROM world
           WHERE name = 'United Kingdom') &&
           continent = 'Europe'
-- 3.
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent FROM world 
                    WHERE name IN ('Argentina', 'Australia')) 
                    ORDER BY name;
-- 4.
SELECT name, population 
FROM world 
WHERE population > (SELECT population FROM world WHERE name = 'Canada') &&  
population < (SELECT population FROM world WHERE name = 'Poland');
-- 5.
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100), '%') 
FROM world 
WHERE continent = 'Europe'; 
-- As noted in the tutorial, questions 6 - 10 in this unit are considered bonuses, just like units 6 - 8+
-- 6.
SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp 
            FROM world 
            WHERE gdp > 0 AND continent = 'Europe')
-- 7.
SELECT continent, name, area
FROM world x
WHERE area >= ALL
    (SELECT area FROM world y
     WHERE y.continent=x.continent
     AND area > 0)
-- 8.

-- 9.

-- 10.



-- 5 SUM and COUNT
-- 1.
SELECT SUM(population)
FROM world
-- 2.
SELECT DISTINCT(continent)
FROM world
-- 3.
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'
-- 4.
SELECT COUNT(name)
FROM world
WHERE area > 1000000
-- 5.
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
-- 6.
SELECT continent, COUNT(name)
FROM world
GROUP BY continent
-- 7.
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent
-- 8.
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000


-- Note: the units below this are bonus for this weekend, and they will be required in a future assignment. If you do them now you will be ahead of the game!
-- 6 JOIN
-- 1.
SELECT matchid, player
FROM goal 
WHERE teamid LIKE 'GER'
-- 2.
SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012
-- 3.
SELECT player,teamid,stadium,mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamID = 'GER'
-- 4.
SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'
-- 5.
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON teamid=id
WHERE gtime<=10
-- 6.
SELECT mdate,teamname
FROM game JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos'
-- 7.
SELECT player
FROM goal JOIN game ON (matchid=id)
WHERE stadium = 'National Stadium, Warsaw'
-- 8.
SELECT DISTINCT player
FROM game JOIN goal ON (matchid=id) 
WHERE (team1='GER' OR team2='GER')
      && teamid != 'GER'
-- 9.
SELECT teamname, COUNT(gtime)
FROM eteam JOIN goal ON (id=teamid)
GROUP BY teamname
-- 10.
SELECT stadium, COUNT(matchid)
FROM game JOIN goal ON (matchid=id)
GROUP BY stadium
-- 11.
SELECT matchid,mdate, COUNT(*)
FROM game JOIN goal ON (matchid = id) 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate
-- 12.
SELECT matchid, mdate, COUNT(*)
FROM goal JOIN game ON (matchid = id)
WHERE (teamid = 'GER')
GROUP BY matchid, mdate
-- 13.



-- 7 More JOIN operations
-- 1.
SELECT id, title
FROM movie
WHERE yr=1962
-- 2.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'
-- 3.
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr
-- 4.
SELECT id
FROM actor JOIN casting ON (id = actorid)
WHERE name LIKE 'Glenn Close'
GROUP BY id
-- 5.
SELECT id
FROM movie
WHERE title LIKE 'Casablanca'
-- 6.
SELECT name
FROM movie JOIN casting ON movie.id = movieid
           JOIN actor ON actorid = actor.id
WHERE movieid = 11768
-- 7.
SELECT name
FROM movie JOIN casting ON movie.id = movieid
           JOIN actor ON actorid = actor.id
WHERE title = 'Alien'
-- 8.
SELECT title
FROM movie JOIN casting ON movie.id = movieid
          JOIN actor ON actorid = actor.id
WHERE name = 'Harrison Ford'
-- 9.
SELECT title
FROM movie JOIN casting ON movie.id = movieid
          JOIN actor ON actorid = actor.id
WHERE name = 'Harrison Ford'&& 
              ord != 1
-- 10.
SELECT title, name
FROM movie JOIN casting ON movie.id = movieid
           JOIN actor ON actorid = actor.id
WHERE yr = 1962 &&
      ord = 1
-- 11.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
-- 12.
SELECT title, name
FROM movie JOIN casting ON (movieid = movie.id && ord = 1)
           JOIN actor ON (actorid = actor.id)
WHERE movie.id IN 
(SELECT movieid FROM casting
 WHERE actorid IN 
  (SELECT id FROM actor
    WHERE name = 'Julie Andrews'))
-- 13.
SELECT name
FROM actor JOIN casting ON (actorid = actor.id)
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 15;
-- 14.
SELECT title, COUNT(actorid) 
FROM movie JOIN casting ON (movie.id = movieid) 
WHERE yr = 1978
GROUP BY title 
ORDER BY COUNT(actorid) DESC, title
-- 15.
SELECT name 
FROM actor JOIN casting ON (actor.id = actorid)
WHERE movieid IN (SELECT id FROM movie WHERE title IN
                 (SELECT title FROM movie JOIN casting ON (movie.id = movieid) 
                  WHERE actorid IN (SELECT id FROM actor 
                  WHERE name = 'Art Garfunkel'))) AND name != 'Art Garfunkel'

-- 8 Using Null
-- 1.
SELECT name
FROM teacher
WHERE dept IS NULL
-- 2.
SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept
             ON (teacher.dept=dept.id)
-- 3.
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept
             ON (teacher.dept=dept.id)
-- 4.
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept
             ON (teacher.dept=dept.id)
-- 5.
SELECT name, COALESCE(mobile, '07986 444 2266')
FROM teacher
-- 6.
SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id)
-- 7.
SELECT COUNT(name), COUNT(mobile)
FROM teacher
-- 8.
SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)
GROUP BY dept.name
-- 9.
SELECT teacher.name,
CASE WHEN dept.id = 1 THEN 'Sci'
     WHEN dept.id = 2 THEN 'Sci'
     ELSE 'Art' END
FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id)
-- 10.
SELECT teacher.name,
CASE WHEN dept.id = 1 THEN 'Sci'
     WHEN dept.id = 2 THEN 'Sci'
     WHEN dept.id = 3 THEN 'Art'
     ELSE 'None' END
FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id)


-- 8+ Numeric Examples
-- 1.

-- 2.

-- 3.

-- 4.

-- 5.

-- 6.

-- 7.

-- 8.

