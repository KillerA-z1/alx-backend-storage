-- Task 4: Buy buy buy - creates a trigger that decreases the quantity of an item when a new order is inserted
-- This trigger, named `order_decrease`, is executed before a new row is inserted into the `orders` table.
-- It updates the `items` table by decreasing the `quantity` of the item specified in the new order.
-- The `quantity` is reduced by the number of items in the new order (`NEW.number`).
-- The update is applied to the item whose `name` matches the `item_name` in the new order (`NEW.item_name`).
CREATE TRIGGER order_decrease BEFORE INSERT ON orders
FOR EACH ROW UPDATE items
SET quantity = quantity - NEW.number
WHERE name = NEW.item_name;
