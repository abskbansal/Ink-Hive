INSERT INTO addresses
    (house_number, city, state, PINCODE)
VALUES
    ('123', 'New York',      'NY', 10001),
    ('456', 'Los Angeles',   'CA', 90001),
    ('789', 'Chicago',       'IL', 60601),
    ('101', 'Houston',       'TX', 77001),
    ('202', 'Miami',         'FL', 33101),
    ('303', 'Seattle',       'WA', 98101),
    ('404', 'Boston',        'MA', 02101),
    ('505', 'San Francisco', 'CA', 94101),
    ('606', 'Philadelphia',  'PA', 19101),
    ('707', 'Phoenix',       'AZ', 85001);

INSERT INTO employees
    (`name`, date_of_joining, salary, email, phone, addressID, passwd)
VALUES
    ('John Doe',    '2023-01-15', 50000.00, 'john@admin.com',  1234567890, 1, 'password_strong'),
    ('Alice Smith', '2023-02-20', 55000.00, 'alice@admin.com', 2345678901, 2, 'password_strong');

INSERT INTO authors
    (`name`, phone, email)
VALUES
    ('F. Scott Fitzgerald', 1234567890, 'scott@example.com'),
    ('Harper Lee',          2345678901, 'david@example.com'),
    ('George Orwell',       3456789012, 'jennifer@example.com'),
    ('John Ronald',         4567890123, 'james@example.com'),
    ('J K Rownling',        1234567890, 'matthew@example.com'),
    ('Paulo Coelho',        1234567890, 'matthew@example.com'),
    ('R.A. Salvatore',      1234567890, 'matthew@example.com'),
    ('Erika Lewis',         1234567890, 'matthew@example.com');

INSERT INTO publications
    (`name`, email)
VALUES
    ('ABC Publications', 'info@abc.com'),
    ('XYZ Publishers',   'info@xyz.com'),
    ('PQR Books',        'info@pqr.com'),
    ('NOP Printers',     'info@nop.com');

INSERT INTO suppliers
    (supplierID, `name`, email)
VALUES
    (1, 'Books R Us',     'info@booksrus.com'),
    (2, 'Book World',     'info@bookworld.com'),
    (3, 'Readers Corner', 'info@readerscorner.com'),
    (4, 'Book Mart',      'info@bookmart.com'),
    (5, 'Book Haven',     'info@bookhaven.com'),
    (6, 'Book Outlet',    'info@bookoutlet.com'),
    (7, 'Books & Beyond', 'info@booksandbeyond.com');

INSERT INTO books
    (`name`, genre, publicationID, supplierID, price, year_of_publishing, qty)
VALUES
    ('The Great Gatsby',                       'Fiction',          1, 2, 180,  2003, 100),
    ('To Kill a Mockingbird',                  'Classic',          2, 4, 320,  2003, 100),
    ('1984',                                   'Science Fiction',  2, 5, 328,  2003, 100),
    ('Animal Farm',                            'Fiction',          3, 4, 432,  2003, 100),
    ('The Hobbit',                             'Fantasy',          3, 6, 304,  2003, 100),
    ('Harry Potter and the Sorcerer''s Stone', 'Fantasy',          4, 5, 320,  2003, 100),
    ('The Lord of the Rings',                  'Fantasy',          1, 2, 1178, 2003, 100),
    ('The Alchemist',                          'Fiction',          3, 1, 208,  2003, 100),
    ('The Color of Dragons',                   'Fiction',          4, 4, 208,  2003, 100);

INSERT INTO written_by
    (bookID, authorID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 3),
    (5, 4),
    (6, 5),
    (7, 4),
    (8, 6),
    (9, 7),
    (9, 8);

INSERT INTO carts
    (cartID, bookID, qty)
VALUES
    (1, 4, 2),
    (1, 8, 3),
    (1, 1, 1),
    (2, 1, 2),
    (2, 8, 1);

INSERT INTO customers
    (`name`, phone, email, passwd, addressID, cartID)
VALUES
    ('Anish',  1234567890, 'anish22075@iiitd.ac.in',  "password_strong", 3, 1),
    ('Adarsh', 2345678901, 'adarsh22024@iiitd.ac.in', "password_strong", 4, 2);

INSERT INTO shippers
    (`name`, vehicle_number, phone)
VALUES
    ('Fast Delivery',    'ABC123', 1234567890),
    ('Quick Ship',       'XYZ456', 2345678901),
    ('Swift Transport',  'LMN789', 3456789012),
    ('Speedy Logistics', 'PQR123', 4567890123),
    ('Rapid Movers',     'EFG456', 5678901234);

INSERT INTO `orders`
    (amount, date_of_order, customerID, payment_method, shipperID, `status`)
VALUES
    (100.00, '2024-01-01', 1, 'Credit Card', 4, 'Shipped'),
    (200.00, '2024-01-03', 1, 'Debit Card' , 3, 'Shipped'),
    (150.00, '2024-01-02', 2, 'PayPal'     , 2, 'Shipped'),
    (120.00, '2024-01-04', 2, 'Cash'       , 2, 'Shipped');

INSERT INTO `contains`
    (orderID, bookID, no_of_copies)
VALUES
    (1, 1, 2),
    (1, 2, 3),
    (2, 1, 1),
    (2, 4, 2),
    (2, 5, 2),
    (3, 3, 3),
    (4, 1, 2),
    (4, 6, 2);