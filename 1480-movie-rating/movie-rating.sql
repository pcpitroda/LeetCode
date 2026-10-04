# Write your MySQL query statement below
With cte AS (
    SELECT  
        mr.movie_id,
        mr.user_id,
        m1.title,
        u1.name ,
        mr.created_at,
        mr.rating
    FROM Movierating as mr 
    INNER JOIN Movies as m1 
    ON mr.movie_id = m1.movie_id
    INNER JOIN Users as u1 
    ON mr.user_id = u1.user_id 
)

(
    SELECT name as results
    FROM cte
    GROUP BY user_id, name
    ORDER BY COUNT(*) DESC, name ASC
    LIMIT 1
)

UNION ALL

(
    SELECT t.title 
    FROM 
    (
    SELECT title ,rating ,created_at
    FROM cte 
    WHERE created_at >= '2020-02-01'
    AND created_at < '2020-03-01'
    ) as t
    GROUP BY title 
    ORDER BY AVG(rating) DESC ,title ASC
    LIMIT 1
)