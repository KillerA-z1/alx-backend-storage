-- Task 8: Optimize simple search
-- This script creates an index named 'idx_name_first' on the 'names' table.
-- The index is created on the first letter of the 'name' column to optimize search queries.
CREATE INDEX idx_name_first ON names ( name(1) );
