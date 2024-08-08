DROP DATABASE IF EXISTS dbms_proj;
CREATE DATABASE dbms_proj;
USE dbms_proj;

CREATE TABLE addresses (
    addressID INTEGER PRIMARY KEY AUTO_INCREMENT,
    house_number VARCHAR(32) NOT NULL,
    city VARCHAR(32) NOT NULL,
    state VARCHAR(32) NOT NULL,
    PINCODE INTEGER NOT NULL
);

CREATE TABLE employees (
    employeeID INTEGER AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    date_of_joining DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    email VARCHAR(32),
    phone BIGINT NOT NULL,
    passwd VARCHAR(32) NOT NULL,
    addressID INTEGER,

    PRIMARY KEY (employeeID),
    FOREIGN KEY (addressID) REFERENCES addresses(addressID)
);

CREATE TABLE authors (
    authorID INTEGER AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    phone BIGINT,
    email VARCHAR(32) NOT NULL,

    PRIMARY KEY (authorID)
);

CREATE TABLE publications (
    publicationID INTEGER AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    email VARCHAR(32) NOT NULL,

    PRIMARY KEY (publicationID)
);

CREATE TABLE suppliers (
    supplierID INTEGER AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    email VARCHAR(32) NOT NULL,

    PRIMARY KEY (supplierID)
);

CREATE TABLE books (
    bookID INTEGER AUTO_INCREMENT,
    `name` VARCHAR(64) NOT NULL,
    genre VARCHAR(16) NOT NULL,
    publicationID INTEGER NOT NULL,
    supplierID INTEGER NOT NULL,
    price DECIMAL(10, 2),
    year_of_publishing INTEGER NOT NULL,
    qty INTEGER NOT NULL,

    PRIMARY KEY (bookID),
    FOREIGN KEY (publicationID) REFERENCES publications(publicationID),
    FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID)
);

CREATE TABLE written_by (
    bookID INTEGER,
    authorID INTEGER,

    PRIMARY KEY (bookID, authorID),
    FOREIGN KEY (bookID) REFERENCES books(bookID),
    FOREIGN KEY (authorID) REFERENCES authors(authorID)
);


CREATE TABLE customers (
    customerID INTEGER AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    phone BIGINT NOT NULL,
    email VARCHAR(32) UNIQUE,
    `status` VARCHAR(7) DEFAULT 'active',
    passwd VARCHAR(32) NOT NULL,
    attempts_left INTEGER DEFAULT 3,
    block_time DATETIME(0),
    addressID INTEGER,

    PRIMARY KEY (customerID),
    FOREIGN KEY (addressID) REFERENCES addresses(addressID)
);

CREATE TABLE carts (
    customerID INTEGER,
    bookID INTEGER,
    qty INTEGER,

    PRIMARY KEY (customerID, bookID),
    FOREIGN KEY (bookID) REFERENCES books(bookID),
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
);

CREATE TABLE shippers (
    shipperID INTEGER AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(32) NOT NULL,
    vehicle_number VARCHAR(32) NOT NULL,
    phone BIGINT NOT NULL
);

CREATE TABLE `orders` (
    orderID INTEGER AUTO_INCREMENT,
    amount DECIMAL(10, 2) NOT NULL,
    date_of_order DATE NOT NULL,
    customerID INTEGER,
    payment_method VARCHAR(16) NOT NULL,
    shipperID INTEGER,
    `status` VARCHAR(10),

    PRIMARY KEY (orderID),
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);

CREATE TABLE `contains` (
    orderID INTEGER,
    bookID INTEGER,
    no_of_copies INTEGER NOT NULL,

    PRIMARY KEY (bookID, orderID),
    FOREIGN KEY (bookID) REFERENCES books(bookID),
    FOREIGN KEY (orderID) REFERENCES `orders`(orderID)
);

ALTER TABLE customers
    ADD CONSTRAINT fk_customer_address FOREIGN KEY (addressID) REFERENCES addresses(addressID) ON DELETE CASCADE;

ALTER TABLE orders
    ADD CONSTRAINT fk_order_customer FOREIGN KEY (customerID) REFERENCES customers(customerID) ON DELETE CASCADE,
    ADD CONSTRAINT fk_order_shipper FOREIGN KEY (shipperID) REFERENCES shippers(shipperID) ON DELETE SET NULL;

ALTER TABLE contains
    ADD CONSTRAINT fk_contains_book FOREIGN KEY (bookID) REFERENCES books(bookID) ON DELETE CASCADE,
    ADD CONSTRAINT fk_contains_order FOREIGN KEY (orderID) REFERENCES orders(orderID) ON DELETE CASCADE;
