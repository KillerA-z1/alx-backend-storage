-- This script creates a table named `users` with the following columns:
-- - `id`: An integer that serves as the primary key and auto-increments.
-- - `email`: A varchar field for storing email addresses, which must be unique and not null.
-- - `name`: A varchar field for storing user names.
-- - `country`: An enum field that can only contain the values 'US', 'CO', or 'TN', and must not be null.
CREATE TABLE IF NOT EXISTS `users` (  
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `name` VARCHAR(255),
    `country` ENUM('US', 'CO', 'TN') NOT NULL 
)
