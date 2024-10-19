-- Task: 0. We are all unique! - creates a table users
-- Description: This script creates a table named `users` with the following columns:
--              - `id`: An integer that serves as the primary key and auto-increments.
--              - `email`: A varchar field with a maximum length of 255 characters, which must be unique and not null.
--              - `name`: A varchar field with a maximum length of 255 characters.
-- Note: The script includes a check to create the table only if it does not already exist.
-- Usage: This script can be executed on any database.
CREATE TABLE If NOT EXISTS `users` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `name` VARCHAR(255)
);
