-- This script creates a view named 'need_meeting' that lists all students
-- who have a score strictly under 80 and either have no recorded last_meeting
-- or their last_meeting was more than 1 month ago.
-- The script first drops the view if it already exists to avoid conflicts.
-- creates a view need_meeting that lists all students
-- that have a score under 80 (strict) and no last_meeting or more than 1 month
DROP VIEW IF EXISTS need_meeting;
CREATE VIEW need_meeting
AS SELECT name FROM students
WHERE score < 80 AND last_meeting is NULL
OR last_meeting < DATE_SUB(NOW(), INTERVAL 1 MONTH);
