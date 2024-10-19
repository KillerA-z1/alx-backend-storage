-- Task 9: Optimize search and score
-- This script creates an index named 'idx_name_first_score' on the 'names' table.
-- The index is created on the first letter of the 'name' column and the 'score' column.
-- This helps in optimizing queries that filter or sort based on the first letter of the name and the score.
CREATE INDEX idx_name_first_score ON names ( name(1), score );
