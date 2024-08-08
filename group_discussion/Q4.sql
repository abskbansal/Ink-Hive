-- A
SELECT name
FROM album
WHERE `type` = 'audio' AND date_of_release BETWEEN '2020-01-01' AND '2020-12-31';

-- B
SELECT DISTINCT c.name
FROM candidate c
JOIN (
    SELECT candidateID
    FROM belongs
    GROUP BY candidateID
    HAVING COUNT(groupID) > 1
) AS m ON c.candidateID = m.candidateID;

-- C
SELECT DISTINCT c.name
FROM candidate AS c
JOIN (
    SELECT p.candidateID
    FROM (
        SELECT DISTINCT B.candidateID
        FROM belongs AS B
        JOIN `group` AS G ON B.groupID = G.groupID
        WHERE G.name = 'Pop'
    ) AS p
    WHERE p.candidateID NOT IN (
        SELECT DISTINCT B1.candidateID
        FROM belongs AS B1
        JOIN belongs AS B2 ON B1.candidateID = B2.candidateID AND B1.groupID != B2.groupID
    )
) AS f ON c.candidateID = f.candidateID;

-- D
SELECT name
FROM candidate
WHERE candidateID IN (
    SELECT DISTINCT E1.candidateID
    FROM `entry` AS E1
    INNER JOIN `entry` AS E2 ON E1.candidateID = E2.candidateID
    WHERE E1.type = 'audio' AND E2.type = 'video'
);

-- E
SELECT channel
FROM (
    SELECT channel, COUNT(*) AS entries
    FROM `entry`
    GROUP BY channel
) AS subquery
WHERE entries = (SELECT MAX(entries) FROM (SELECT COUNT(*) AS entries FROM `entry` GROUP BY channel) AS max_entries);
