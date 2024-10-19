-- Task 12: Average weighted score - creates a stored procedure ComputeAverageWeightedScoreForUser that computes and stores the average weighted score for a student.
-- 
-- Parameters:
--   user_id (INT): The ID of the user for whom the average weighted score is to be computed. This is assumed to be linked to an existing user in the users table.
--
-- Procedure:
--   1. Drops the procedure if it already exists.
--   2. Creates a new procedure ComputeAverageWeightedScoreForUser.
--   3. Declares a variable w_avg_score to store the computed average weighted score.
--   4. Computes the weighted average score by joining the users, corrections, and projects tables.
--   5. Updates the average_score field in the users table with the computed weighted average score for the specified user.
--   6. End of the procedure.
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser;
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(user_id INT)
BEGIN
    DECLARE w_avg_score FLOAT;
    SET w_avg_score = (SELECT SUM(score * weight) / SUM(weight) 
                        FROM users AS U 
                        JOIN corrections as C ON U.id=C.user_id 
                        JOIN projects AS P ON C.project_id=P.id 
                        WHERE U.id=user_id);
    UPDATE users SET average_score = w_avg_score WHERE id=user_id;
END
$$
DELIMITER ;
