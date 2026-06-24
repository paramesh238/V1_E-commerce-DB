-- Database Creation
CREATE DATABASE EcommerceDB;

-- Using EcommerceDB
USE EcommerceDB;

-- Create Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Drop table if it already exists
DROP TABLE IF EXISTS products;

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- Drop table if it already exists
DROP TABLE IF EXISTS orders;

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    CONSTRAINT fk_orders_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

-- Drop table if it already exists
DROP TABLE IF EXISTS order_items;

-- Create Order_Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),

    CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Drop table if it already exists
DROP TABLE IF EXISTS payments;

-- Create Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL
    CHECK (status IN ('Completed', 'Pending', 'Failed', 'Refunded')),

    CONSTRAINT fk_payments_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

-- User Authentication Table
CREATE TABLE user_login
(
    login_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    username VARCHAR(50) UNIQUE,
    password_hash VARCHAR(255),
    last_login DATETIME,

    FOREIGN KEY(user_id)
    REFERENCES users(user_id)
);


-- Inserting 30 Random Records into the users table
INSERT INTO users (user_id, name, email, password) VALUES
(1, 'Aarav Sharma', 'aarav.sharma@email.com', 'Pass@101'),
(2, 'Priya Reddy', 'priya.reddy@email.com', 'Pass@102'),
(3, 'Rahul Verma', 'rahul.verma@email.com', 'Pass@103'),
(4, 'Sneha Patel', 'sneha.patel@email.com', 'Pass@104'),
(5, 'Karan Gupta', 'karan.gupta@email.com', 'Pass@105'),
(6, 'Ananya Singh', 'ananya.singh@email.com', 'Pass@106'),
(7, 'Vikram Rao', 'vikram.rao@email.com', 'Pass@107'),
(8, 'Meera Nair', 'meera.nair@email.com', 'Pass@108'),
(9, 'Rohan Kumar', 'rohan.kumar@email.com', 'Pass@109'),
(10, 'Pooja Das', 'pooja.das@email.com', 'Pass@110'),
(11, 'Arjun Mehta', 'arjun.mehta@email.com', 'Pass@111'),
(12, 'Kavya Iyer', 'kavya.iyer@email.com', 'Pass@112'),
(13, 'Nikhil Joshi', 'nikhil.joshi@email.com', 'Pass@113'),
(14, 'Divya Kapoor', 'divya.kapoor@email.com', 'Pass@114'),
(15, 'Siddharth Jain', 'siddharth.jain@email.com', 'Pass@115'),
(16, 'Neha Agarwal', 'neha.agarwal@email.com', 'Pass@116'),
(17, 'Aditya Mishra', 'aditya.mishra@email.com', 'Pass@117'),
(18, 'Ritika Chawla', 'ritika.chawla@email.com', 'Pass@118'),
(19, 'Manish Yadav', 'manish.yadav@email.com', 'Pass@119'),
(20, 'Shreya Kulkarni', 'shreya.kulkarni@email.com', 'Pass@120'),
(21, 'Amit Tiwari', 'amit.tiwari@email.com', 'Pass@121'),
(22, 'Nisha Bansal', 'nisha.bansal@email.com', 'Pass@122'),
(23, 'Deepak Saxena', 'deepak.saxena@email.com', 'Pass@123'),
(24, 'Tanvi Arora', 'tanvi.arora@email.com', 'Pass@124'),
(25, 'Harsh Vardhan', 'harsh.vardhan@email.com', 'Pass@125'),
(26, 'Ishita Malhotra', 'ishita.malhotra@email.com', 'Pass@126'),
(27, 'Yash Thakur', 'yash.thakur@email.com', 'Pass@127'),
(28, 'Simran Kaur', 'simran.kaur@email.com', 'Pass@128'),
(29, 'Varun Sehgal', 'varun.sehgal@email.com', 'Pass@129'),
(30, 'Ayesha Khan', 'ayesha.khan@email.com', 'Pass@130');

-- Retrieving the records in users table
SELECT * FROM users LIMIT 5; 

-- Inserting 50 records into Product Records
INSERT INTO products (product_id, name, price, stock) VALUES
(1, 'Wireless Mouse', 599.00, 120),
(2, 'Mechanical Keyboard', 2499.00, 45),
(3, 'USB-C Charger 65W', 1499.00, 80),
(4, 'Bluetooth Speaker', 1999.00, 60),
(5, 'Gaming Headset', 3299.00, 35),
(6, 'Laptop Stand', 899.00, 75),
(7, 'HD Webcam', 2199.00, 50),
(8, 'External SSD 500GB', 4299.00, 40),
(9, 'Portable HDD 1TB', 3799.00, 55),
(10, 'Wi-Fi Router', 2899.00, 30),
(11, 'LED Desk Lamp', 1099.00, 90),
(12, 'Smartphone Tripod', 699.00, 65),
(13, 'Noise Cancelling Earbuds', 5499.00, 25),
(14, 'Monitor 24 Inch', 10999.00, 18),
(15, 'USB Hub 4-Port', 499.00, 140),
(16, 'Power Bank 10000mAh', 1399.00, 70),
(17, 'USB Microphone', 2599.00, 28),
(18, 'Graphics Tablet', 6199.00, 12),
(19, 'Smart Watch', 7499.00, 22),
(20, 'Fitness Band', 2499.00, 48),
(21, 'Laptop Backpack', 1599.00, 85),
(22, 'Wireless Presenter', 799.00, 52),
(23, 'Ethernet Cable 5m', 249.00, 200),
(24, 'HDMI Cable 2m', 349.00, 180),
(25, 'Monitor Arm', 2999.00, 16),
(26, 'Desk Organizer', 599.00, 110),
(27, 'Cooling Pad', 1299.00, 58),
(28, 'Surge Protector', 999.00, 77),
(29, 'Wireless Charger', 1699.00, 44),
(30, 'Action Camera', 8999.00, 10),
(31, 'Photo Printer', 12499.00, 8),
(32, 'Ink Cartridge Black', 1299.00, 95),
(33, 'Ink Cartridge Color', 1499.00, 82),
(34, 'Desk Mat XL', 799.00, 66),
(35, 'Phone Case', 399.00, 160),
(36, 'Tempered Glass', 299.00, 170),
(37, 'Car Charger Dual USB', 699.00, 88),
(38, 'Bluetooth Receiver', 899.00, 42),
(39, 'Smart Plug', 1199.00, 53),
(40, 'Mini UPS Router Backup', 3499.00, 19),
(41, 'Portable Projector', 15999.00, 6),
(42, 'Laser Pointer', 499.00, 57),
(43, 'Cable Management Kit', 349.00, 145),
(44, 'Laptop Sleeve 15 Inch', 899.00, 73),
(45, 'USB Flash Drive 128GB', 999.00, 98),
(46, 'USB Flash Drive 256GB', 1699.00, 64),
(47, 'VR Headset', 21999.00, 4),
(48, 'Smart Home Hub', 5999.00, 14),
(49, 'NAS Enclosure 2-Bay', 12999.00, 7),
(50, 'Portable Monitor 15.6 Inch', 14999.00, 11);

-- Verify Data
SELECT * FROM products LIMIT 5;

-- Inserting 30 Sample Order Records
-- Assumes users table contains user_id values from 1 to 30
INSERT INTO orders (order_id, user_id, order_date) VALUES
(1, 1, '2025-01-05'),
(2, 2, '2025-01-08'),
(3, 3, '2025-01-10'),
(4, 1, '2025-01-15'),
(5, 4, '2025-01-18'),
(6, 5, '2025-01-20'),
(7, 2, '2025-01-25'),
(8, 6, '2025-02-01'),
(9, 7, '2025-02-03'),
(10, 3, '2025-02-05'),
(11, 8, '2025-02-08'),
(12, 9, '2025-02-12'),
(13, 4, '2025-02-15'),
(14, 10, '2025-02-18'),
(15, 11, '2025-02-20'),
(16, 5, '2025-02-24'),
(17, 12, '2025-03-01'),
(18, 13, '2025-03-04'),
(19, 6, '2025-03-08'),
(20, 14, '2025-03-12'),
(21, 15, '2025-03-15'),
(22, 7, '2025-03-18'),
(23, 16, '2025-03-20'),
(24, 17, '2025-03-22'),
(25, 8, '2025-03-25'),
(26, 18, '2025-03-28'),
(27, 19, '2025-04-01'),
(28, 9, '2025-04-04'),
(29, 20, '2025-04-08'),
(30, 10, '2025-04-10');

-- Verify inserted data in orders
SELECT * FROM orders LIMIT 5;

-- Inserting 30 Sample Records
-- Assumes:
-- orders table contains order_id values from 1 to 30
-- products table contains product_id values from 1 to 50
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 5, 2),
(2, 1, 12, 1),
(3, 2, 8, 3),
(4, 3, 15, 1),
(5, 4, 20, 2),
(6, 5, 3, 4),
(7, 6, 25, 1),
(8, 7, 10, 2),
(9, 8, 18, 1),
(10, 9, 30, 3),
(11, 10, 7, 2),
(12, 11, 22, 1),
(13, 12, 14, 2),
(14, 13, 35, 1),
(15, 14, 9, 5),
(16, 15, 40, 1),
(17, 16, 6, 2),
(18, 17, 28, 3),
(19, 18, 11, 1),
(20, 19, 45, 2),
(21, 20, 16, 4),
(22, 21, 2, 1),
(23, 22, 33, 2),
(24, 23, 27, 3),
(25, 24, 19, 1),
(26, 25, 50, 2),
(27, 26, 24, 1),
(28, 27, 13, 2),
(29, 28, 38, 3),
(30, 29, 21, 1);

-- Verify Data in order_items table
SELECT * FROM order_items LIMIT 5;

-- Inserting 30 Sample Payment Records
-- Assumes order_id values from 1 to 30 exist in the orders table
INSERT INTO payments (payment_id, order_id, amount, status) VALUES
(1, 1, 6598.00, 'Completed'),
(2, 2, 4299.00, 'Completed'),
(3, 3, 499.00, 'Completed'),
(4, 4, 14998.00, 'Completed'),
(5, 5, 5996.00, 'Completed'),
(6, 6, 5996.00, 'Completed'),
(7, 7, 2899.00, 'Pending'),
(8, 8, 6199.00, 'Completed'),
(9, 9, 26997.00, 'Completed'),
(10, 10, 4398.00, 'Completed'),
(11, 11, 799.00, 'Failed'),
(12, 12, 21998.00, 'Completed'),
(13, 13, 399.00, 'Completed'),
(14, 14, 14495.00, 'Completed'),
(15, 15, 15999.00, 'Pending'),
(16, 16, 1798.00, 'Completed'),
(17, 17, 2997.00, 'Completed'),
(18, 18, 1099.00, 'Completed'),
(19, 19, 1998.00, 'Failed'),
(20, 20, 5596.00, 'Completed'),
(21, 21, 2499.00, 'Completed'),
(22, 22, 2998.00, 'Completed'),
(23, 23, 3897.00, 'Pending'),
(24, 24, 7499.00, 'Completed'),
(25, 25, 29998.00, 'Completed'),
(26, 26, 349.00, 'Completed'),
(27, 27, 2998.00, 'Failed'),
(28, 28, 17997.00, 'Completed'),
(29, 29, 1599.00, 'Completed'),
(30, 30, 8999.00, 'Pending');

-- Verify inserted data in payments
SELECT * FROM payments LIMIT 5;

-- Inserting  20 random records into user_login
INSERT INTO user_login
(
    user_id,
    username,
    password_hash,
    last_login
)
VALUES
(1,  'aarav01',    SHA2('Password@101',256), '2026-06-01 09:15:22'),
(2,  'priya02',    SHA2('Password@102',256), '2026-06-02 10:30:15'),
(3,  'rahul03',    SHA2('Password@103',256), '2026-06-03 11:45:08'),
(4,  'sneha04',    SHA2('Password@104',256), '2026-06-04 08:20:35'),
(5,  'karan05',    SHA2('Password@105',256), '2026-06-05 14:12:18'),
(6,  'ananya06',   SHA2('Password@106',256), '2026-06-06 16:05:40'),
(7,  'vikram07',   SHA2('Password@107',256), '2026-06-07 09:55:10'),
(8,  'meera08',    SHA2('Password@108',256), '2026-06-08 13:22:47'),
(9,  'rohan09',    SHA2('Password@109',256), '2026-06-09 17:40:05'),
(10, 'pooja10',    SHA2('Password@110',256), '2026-06-10 10:18:32'),
(11, 'arjun11',    SHA2('Password@111',256), '2026-06-11 12:45:56'),
(12, 'kavya12',    SHA2('Password@112',256), '2026-06-12 15:30:14'),
(13, 'nikhil13',   SHA2('Password@113',256), '2026-06-13 09:10:45'),
(14, 'divya14',    SHA2('Password@114',256), '2026-06-14 18:05:27'),
(15, 'siddharth15',SHA2('Password@115',256), '2026-06-15 11:20:38'),
(16, 'neha16',     SHA2('Password@116',256), '2026-06-16 14:55:11'),
(17, 'aditya17',   SHA2('Password@117',256), '2026-06-17 16:40:29'),
(18, 'ritika18',   SHA2('Password@118',256), '2026-06-18 08:35:52'),
(19, 'manish19',   SHA2('Password@119',256), '2026-06-19 19:15:44'),
(20, 'shreya20',   SHA2('Password@120',256), '2026-06-20 10:50:03');