-- Task 7: Average score - creates a stored procedure ComputeAverageScoreForUser
-- that computes and stores the overall score for a student.
-- 
-- PROCEDURE: ComputeAverageScoreForUser
-- PARAMETERS:
--   IN user_id INT - The ID of the user for whom the average score is to be computed.
-- 
-- FUNCTIONALITY:
--   1. Declares a variable `avg_score` to store the average score.
--   2. Computes the average score of the user from the `corrections` table.
--   3. Updates the `users` table with the computed average score for the specified user.
-- 
-- USAGE:
--   CALL ComputeAverageScoreForUser(user_id);
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;
DELIMITER $$
CREATE PROCEDURE ComputeAverageScoreForUser(
    IN user_id INT)
BEGIN
    DECLARE avg_score FLOAT;
    SET avg_score = (SELECT AVG(score) FROM corrections WHERE user_id = user_id);
    UPDATE users SET average_score = avg_score WHERE id = user_id;
END
$$
DELIMITER ;
