-- Task 6: Add bonus - creates a stored procedure AddBonus
-- Stored Procedure: AddBonus
-- Parameters:
--   IN user_id int: The ID of the user (student) to whom the bonus is to be added.
--   IN project_name varchar(255): The name of the project for which the bonus is to be added.
--   IN score float: The score of the bonus to be added.
--
-- Description:
--   This stored procedure performs the following actions:
--   1. Inserts a new project into the 'projects' table if it does not already exist.
--   2. Inserts a new correction into the 'corrections' table with the provided user_id, 
--      the project_id corresponding to the project_name, and the score.
DELIMITER |
CREATE PROCEDURE AddBonus (
    IN user_id int,
    IN project_name varchar(255),
    IN score float
)
BEGIN
    INSERT INTO projects (name)
    SELECT project_name FROM DUAL

    WHERE NOT EXISTS (SELECT * FROM projects WHERE name = project_name);
    INSERT INTO corrections (user_id, project_id, score)
    VALUES (user_id, (SELECT id FROM projects WHERE name = project_name), score);
END;
|
