CREATE DATABASE logistics_db;

USE DATABASE logistics_db;

-- Table to store customer details
CREATE TABLE Customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    contact_number VARCHAR(255) UNIQUE,  -- Ensure unique contact number
    email VARCHAR(255)
);

-- Table to store shipment details
CREATE TABLE Shipments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,  -- Foreign key to reference the customer
    shipment_type VARCHAR(255),
    pickup_location VARCHAR(255),
    delivery_location VARCHAR(255),
    preferred_time_slot VARCHAR(255),
    tracking_number VARCHAR(255) UNIQUE,  -- Unique tracking number
    status VARCHAR(255) DEFAULT 'pending',
    estimated_delivery_time VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES Customers(id)  -- Link to Customers table
);

SELECT * FROM customers;

SELECT * FROM shipments;