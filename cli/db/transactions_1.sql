-- Transaction 1: Add Employee Record
START TRANSACTION;

INSERT INTO addresses (house_number, city, state, PINCODE) VALUES ('123', 'City', 'State', 12345);
SET @addressID = LAST_INSERT_ID();

INSERT INTO employees (`name`, date_of_joining, salary, email, phone, passwd, addressID) 
VALUES ('John Doe', '2024-04-20', 50000.00, 'john@example.com', 1234567890, 'password', @addressID);

COMMIT;

-- Transaction 2: Add Book
START TRANSACTION;

INSERT INTO publications (`name`, email) VALUES ('Publisher Name', 'publisher@example.com');
SET @publicationID = LAST_INSERT_ID();

INSERT INTO suppliers (`name`, email) VALUES ('Supplier Name', 'supplier@example.com');
SET @supplierID = LAST_INSERT_ID();

INSERT INTO books (`name`, genre, publicationID, supplierID, price, year_of_publishing, qty) 
VALUES ('Book Name', 'Fiction', @publicationID, @supplierID, 20.00, 2023, 100);

COMMIT;

-- Transaction 3: Place Order
START TRANSACTION;

INSERT INTO orders (amount, date_of_order, customerID, payment_method, `status`) 
VALUES (100.00, '2024-04-20', 1, 'Credit Card', 'Pending');
SET @orderID = LAST_INSERT_ID();

INSERT INTO contains (orderID, bookID, no_of_copies) VALUES (@orderID, 1, 2);

COMMIT;

-- Transaction 4: Update Employee Salary
START TRANSACTION;

UPDATE employees SET salary = 55000.00 WHERE employeeID = 1;

COMMIT;

-- Transaction 5: Purchase Books and Update Customer Details
START TRANSACTION;

INSERT INTO orders (amount, date_of_order, customerID, payment_method, `status`) 
VALUES (50.00, '2024-04-20', 1, 'Credit Card', 'Pending');
SET @orderID = LAST_INSERT_ID();

INSERT INTO contains (orderID, bookID, no_of_copies) VALUES 
(@orderID, 2, 1), 
(@orderID, 3, 2);

UPDATE customers SET attempts_left = attempts_left - 1 WHERE customerID = 1;
UPDATE customers SET block_time = NOW() WHERE attempts_left = 0 AND block_time IS NULL;

COMMIT;

-- Transaction 6: Add New Book, Author, and Supplier
START TRANSACTION;

INSERT INTO authors (`name`, phone, email) VALUES ('Emily Brown', 9876543210, 'emily@example.com');
SET @authorID = LAST_INSERT_ID();

INSERT INTO suppliers (`name`, email) VALUES ('Book Supplier Inc.', 'supplier2@example.com');
SET @supplierID = LAST_INSERT_ID();

INSERT INTO books (`name`, genre, publicationID, supplierID, price, year_of_publishing, qty) 
VALUES ('New Mystery Book', 'Mystery', 2, @supplierID, 30.00, 2024, 100);

COMMIT;
