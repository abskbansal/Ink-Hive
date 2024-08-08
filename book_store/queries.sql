-- Show the book names that are written by 'Jane Smith'
SELECT b.name AS book_name
FROM book b
INNER JOIN written_by auth ON b.ISBN = auth.ISBN
WHERE auth.name = 'Jane Smith';

-- Show the customers who have provided their email
SELECT * FROM customer WHERE email IS NOT NULL;

-- Show all the books and their editions
SELECT b.name AS book_name, e.price AS edition_price
FROM book b
INNER JOIN edition e ON b.ISBN = e.ISBN;

-- Show the authors who have not reviewed any books
SELECT a.*
FROM author a
LEFT JOIN reviewed_by r ON a.authorID = r.authorID
WHERE r.authorID IS NULL;

-- Show ustomers along with their addresses
SELECT c.name AS customer_name, a.*
FROM customer c
INNER JOIN has_address ha ON c.customerID = ha.customerID
INNER JOIN address a ON ha.addressID = a.addressID;

-- Show the total amount spent by each customer
SELECT c.name AS customer_name, SUM(o.amount) AS total_spent
FROM customer c
INNER JOIN `order` o ON c.customerID = o.customerID
GROUP BY c.name;

-- Show the number of copies of each book ordered
SELECT c.ISBN, b.name AS book_name, SUM(c.no_of_copies) AS total_copies_ordered
FROM `contains` c
INNER JOIN book b ON c.ISBN = b.ISBN
GROUP BY c.ISBN;

-- Show the total number of editions published in a specific year
SELECT year_of_publishing, COUNT(*) AS total_editions_published
FROM edition
GROUP BY year_of_publishing;

-- Show the orders with their corresponding shippers and shipping statuses
SELECT o.orderID, s.name AS shipper_name, sb.status AS shipping_status
FROM `order` o
INNER JOIN shipped_by sb ON o.orderID = sb.orderID
INNER JOIN shipper s ON sb.shipperID = s.shipperID;

-- Show customers who have placed orders with a total amount greater than $100
SELECT * 
FROM customer 
WHERE customerID IN (
    SELECT o.customerID 
    FROM `order` o 
    GROUP BY o.customerID 
    HAVING SUM(o.amount) > 100
);

-- Show authors who have reviewed books published by a specific publication
SELECT * 
FROM author 
WHERE authorID IN (
    SELECT r.authorID 
    FROM reviewed_by r 
    WHERE r.ISBN IN (
        SELECT b.ISBN 
        FROM book b 
        WHERE b.publicationID = (
            SELECT publicationID 
            FROM publication 
            WHERE `name` = 'Example Publication'
        )
    )
);

-- Increase the salary of employees hired before 2020 by 10%
UPDATE employee
SET salary = salary * 1.1
WHERE date_of_joining < '2020-01-01';

-- Set the status of orders shipped by a specific shipper to 'Delivered'
UPDATE shipped_by
SET `status` = 'Delivered'
WHERE shipperID = (
    SELECT shipperID 
    FROM shipper 
    WHERE `name` = 'Fast Delivery'
);