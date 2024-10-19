-- Task 13 - Average weighted score for all! - computes and stores the average weighted score for all students.
-- 
-- This script defines a stored procedure named ComputeAverageWeightedScoreForUsers.
-- The procedure performs the following steps:
-- 1. Drops the procedure if it already exists.
-- 2. Creates a new procedure ComputeAverageWeightedScoreForUsers.
-- 3. The procedure updates the 'average_score' field in the 'users' table.
-- 4. It calculates the weighted average score for each user by:
--    a. Joining the 'users', 'corrections', and 'projects' tables.
--    b. Calculating the weighted average score using the formula: SUM(score * weight) / SUM(weight).
--    c. Grouping the results by user ID.
-- 5. The calculated weighted average score is then set in the 'average_score' field of the 'users' table.
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    UPDATE users AS U, 
        (SELECT U.id, SUM(score * weight) / SUM(weight) AS w_avg 
        FROM users AS U 
        JOIN corrections as C ON U.id=C.user_id 
        JOIN projects AS P ON C.project_id=P.id 
        GROUP BY U.id)
    AS WA
    SET U.average_score = WA.w_avg 
    WHERE U.id=WA.id;
END
$$
DELIMITER ;
