-- Task 10: Safe divide - creates a function SafeDiv that divides two integers safely.
-- Function: SafeDiv
-- Parameters:
--   a (INT): The numerator.
--   b (INT): The denominator.
-- Returns:
--   FLOAT: The result of the division of 'a' by 'b', or 0 if 'b' is 0.
-- Description:
--   This function performs a safe division of two integers. If the denominator
--   is zero, it returns 0 to avoid division by zero errors. Otherwise, it returns
--   the result of the division.
DELIMITER |
DROP FUNCTION IF EXISTS SafeDiv;
CREATE FUNCTION SafeDiv (a INT, b INT)
RETURNS FLOAT
BEGIN
    DECLARE result FLOAT;
    IF b = 0 THEN
        SET result = 0;
    ELSE
        SET result = a / b;
    END IF;
    RETURN result;
END;
|
DELIMITER ;
