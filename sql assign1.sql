CREATE DATABASE salesdata;

use salesdata;

CREATE TABLE Product (
  product_id INT PRIMARY KEY,
  name VARCHAR(100),
  description VARCHAR(200),
  price DECIMAL(10, 2),
  category VARCHAR(50)
);
CREATE TABLE Region (
  region_id INT PRIMARY KEY,
  name VARCHAR(50)
);
CREATE TABLE TimePeriod (
  time_period_id INT PRIMARY KEY,
  name VARCHAR(50)
);
CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  address VARCHAR(200),
  age INT,
  loyalty_status VARCHAR(20)
);
CREATE TABLE Purchase (
  purchase_id INT PRIMARY KEY,
  customer_id INT,
  time_period_id INT,
  total_purchase_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (time_period_id) REFERENCES TimePeriod(time_period_id)
);
CREATE TABLE PurchaseProduct (
  purchase_id INT,
  product_id INT,
  FOREIGN KEY (purchase_id) REFERENCES Purchase(purchase_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
CREATE TABLE ProductRegion (
  product_id INT,
  region_id INT,
  FOREIGN KEY (product_id) REFERENCES Product(product_id),
  FOREIGN KEY (region_id) REFERENCES Region(region_id)
);
CREATE TABLE Inventory (
  inventory_id INT PRIMARY KEY,
  product_id INT,
  stock_level INT,
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
INSERT INTO Product (product_id, name, description, price, category)
VALUES 
  (1, 'Product 1', 'Product 1', 9.99, 'Category 1'),
  (2, 'Product 2', 'Product 2', 19.99, 'Category 2'),
  (3, 'Product 3', 'Product 3', 14.99, 'Category 1'),
  (4, 'Product 4', 'Product 4', 7.99, 'Category 2'),
  (5, 'Product 5', 'Product 5', 12.99, 'Category 3');
  INSERT INTO Region (region_id, name)
VALUES 
  (1, 'Region 1'),
  (2, 'Region 2'),
  (3, 'Region 3'),
  (4, 'Region 4'),
  (5, 'Region 5');
  INSERT INTO TimePeriod (time_period_id, name)
VALUES 
  (1, 'Period 1'),
  (2, 'Period 2'),
  (3, 'Period 3'),
  (4, 'Period 4'),
  (5, 'Period 5');
INSERT INTO Customer (customer_id, name, address, age, loyalty_status)
VALUES 
  (1, 'x', 'Address 1-1', 25, 'Loyal'),
  (2, 'y', 'Address 2-2', 30, 'Regular'),
  (3, 'z', 'Address 3-3', 28, 'Loyal'),
  (4, 'a', 'Address 4-4', 35, 'Regular'),
  (5, 'b', 'Address 5-5', 22, 'Loyal');
INSERT INTO Purchase (purchase_id, customer_id, time_period_id, total_purchase_amount)
VALUES 
  (1, 1, 1, 50.00),
  (2, 2, 2, 75.00),
  (3, 3, 3, 100.00),
  (4, 4, 4, 30.00),
  (5, 5, 5, 60.00);
  INSERT INTO PurchaseProduct (purchase_id, product_id)
VALUES 
  (1, 1),
  (1, 2),
  (2, 1),
  (3, 3),
  (4, 4);
  INSERT INTO ProductRegion (product_id, region_id)
VALUES 
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);
  CREATE TABLE Sales (
  sales_id INT PRIMARY KEY,
  product_id INT,
  region_id INT,
  time_period_id INT,
  quantity INT,
  revenue DECIMAL(10, 2),
  FOREIGN KEY (product_id) REFERENCES Product(product_id),
  FOREIGN KEY (region_id) REFERENCES Region(region_id),
  FOREIGN KEY (time_period_id) REFERENCES TimePeriod(time_period_id)
);
INSERT INTO Sales (sales_id, product_id, region_id, time_period_id, quantity, revenue)
VALUES
  (1, 1, 1, 1, 100, 5000.00),
  (2, 2, 2, 1, 50, 2500.00),
  (3, 1, 2, 2, 75, 3750.00),
  (4, 3, 1, 2, 200, 10000.00);


-- Sales data by product, region, and time:
SELECT p.name AS product_name, r.name AS region_name, tp.name AS time_period_name
FROM Sales s
JOIN Product p ON s.product_id = p.product_id
JOIN Region r ON s.region_id = r.region_id
JOIN TimePeriod tp ON s.time_period_id = tp.time_period_id;

-- Customer data, including demographics, purchase history, and loyalty status:
SELECT c.name AS customer_name, c.age, c.address, ph.purchase_id,ph.time_period_id,ph.total_purchase_amount, c.loyalty_status
FROM Customer c
JOIN Purchase ph ON c.customer_id = ph.customer_id;

ALTER TABLE Inventory
ADD COLUMN availability INT;
INSERT INTO Inventory (inventory_id, product_id, stock_level)
VALUES
  (1, 101, 50),
  (2, 102, 75),
  (3, 103, 100),
  (4, 104, 25),
  (5, 105, 60);
UPDATE Inventory
SET availability = 
    CASE 
        WHEN product_id = 101 THEN 50
        WHEN product_id = 102 THEN 75
        WHEN product_id = 103 THEN 100
        WHEN product_id = 104 THEN 25
        WHEN product_id = 105 THEN 60
    END
WHERE product_id IN (1, 2, 3, 4, 5);

-- Inventory data, including product availability and stock levels:
SELECT p.name AS product_name, i.availability, i.stock_level
FROM Product p
JOIN Inventory i ON p.product_id = i.product_id;






  



