-- Transaction 1: Admin adds a book

UPDATE books SET qty = qty + 50 WHERE `name` = 'The Great Gatsby';

-- Transaction 2: Client places an order for the same book:
START TRANSACTION;

SELECT qty FROM books WHERE `name` = 'The Great Gatsby' FOR UPDATE;

INSERT INTO orders (amount, date_of_order, customerID, payment_method, shipperID, `status`)
VALUES (15.99, CURDATE(), 1, 'Credit Card', 1, 'Processing');

UPDATE books SET qty = qty - 1 WHERE `name` = 'The Great Gatsby';

COMMIT;


-- Transaction 3: Admin Updates Book Information
START TRANSACTION;

SET @bookID = (SELECT bookID FROM books WHERE `name` = 'The Great Gatsby');

UPDATE books SET price = 19.99 WHERE bookID = @bookID;

COMMIT;

-- Transaction 4: Client D Places an Order with Old Price
START TRANSACTION;

SELECT qty FROM books WHERE `name` = 'The Great Gatsby' FOR UPDATE;
SET @price = (SELECT price FROM books WHERE `name` = 'The Great Gatsby');

INSERT INTO orders (amount, date_of_order, customerID, payment_method, shipperID, `status`)
VALUES (@price, CURDATE(), 1, 'Credit Card', 1, 'Processing');

UPDATE books SET qty = qty - 1 WHERE `name` = 'The Great Gatsby';

COMMIT;
