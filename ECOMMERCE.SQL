-- SQL Script for E-commerce Database Schema

-- Drop database if it exists to ensure a clean start
DROP DATABASE IF EXISTS ecommerce_db;

-- Create the database
CREATE DATABASE ecommerce_db;

-- Use the newly created database
USE ecommerce_db;

-- -----------------------------------------------------
-- Table `ecommerce_db`.`Categories`
-- -----------------------------------------------------
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- -----------------------------------------------------
-- Table `ecommerce_db`.`Products`
-- -----------------------------------------------------
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON DELETE SET NULL -- If a category is deleted, products in that category will have their category_id set to NULL
        ON UPDATE CASCADE   -- If a category_id is updated, related product category_ids will also be updated
);

-- -----------------------------------------------------
-- Table `ecommerce_db`.`Customers`
-- -----------------------------------------------------
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Table `ecommerce_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE RESTRICT -- Prevent deletion of a customer if they have associated orders
        ON UPDATE CASCADE   -- If a customer_id is updated, related order customer_ids will also be updated
);

-- -----------------------------------------------------
-- Table `ecommerce_db`.`Order_Items`
-- This is a junction table to handle the Many-to-Many relationship between Orders and Products
-- -----------------------------------------------------
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL, -- Price of the product at the time of order
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE -- If an order is deleted, its order items should also be deleted
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE RESTRICT -- Prevent deletion of a product if it's part of an order item
        ON UPDATE CASCADE,
    UNIQUE (order_id, product_id) -- Ensures that a product appears only once per order item entry
);

-- Optional: Add indexes for performance improvement on frequently queried columns
CREATE INDEX idx_product_name ON Products(product_name);
CREATE INDEX idx_customer_email ON Customers(email);
CREATE INDEX idx_order_date ON Orders(order_date);

-- Optional: Insert some sample data to test the schema
INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Gadgets and electronic devices.'),
('Books', 'Various genres of books.'),
('Clothing', 'Apparel for men and women.');

INSERT INTO Products (product_name, description, price, stock_quantity, category_id) VALUES
('Laptop Pro', 'High-performance laptop.', 1200.00, 50, 1),
('The Great Novel', 'A captivating story.', 25.00, 150, 2),
('T-Shirt Basic', 'Comfortable cotton t-shirt.', 15.00, 200, 3),
('Smartphone X', 'Latest model smartphone.', 800.00, 100, 1);

INSERT INTO Customers (first_name, last_name, email, phone_number, address, city, state, zip_code) VALUES
('Alice', 'Smith', 'alice.smith@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '90210'),
('Bob', 'Johnson', 'bob.johnson@example.com', '987-654-3210', '456 Oak Ave', 'Otherville', 'NY', '10001');

INSERT INTO Orders (customer_id, total_amount, order_status) VALUES
(1, 1225.00, 'Processing'),
(2, 815.00, 'Pending');

INSERT INTO Order_Items (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 1200.00),
(1, 3, 1, 15.00),
(2, 4, 1, 800.00),
(2, 3, 1, 15.00);