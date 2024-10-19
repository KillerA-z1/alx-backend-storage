-- Task 5: Email validation to sent - creates a trigger that resets the attribute valid_email
-- only when the email has been changed.
-- 
-- This trigger, named 'email_bool', is executed before an update operation on the 'users' table.
-- It checks if the 'email' field in the new row is different from the old row.
-- If the email has changed, it sets the 'valid_email' field to 0.
DELIMITER |
CREATE TRIGGER email_bool BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.email <> OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END;
|
DELIMITER ;
