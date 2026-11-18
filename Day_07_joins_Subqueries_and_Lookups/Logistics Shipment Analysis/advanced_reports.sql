CREATE DATABASE logistics_db;
USE logistics_db;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE carriers (
    carrier_id INT PRIMARY KEY,
    carrier_name VARCHAR(100)
);

CREATE TABLE hubs (
    hub_id INT PRIMARY KEY,
    hub_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    hub_id INT,
    supervisor_id INT,
    FOREIGN KEY (hub_id) REFERENCES hubs(hub_id),
    FOREIGN KEY (supervisor_id) REFERENCES employees(employee_id)
);

CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    customer_id INT,
    carrier_id INT,
    origin_hub_id INT,
    destination_hub_id INT,
    shipping_cost DECIMAL(10,2),
    delay_days INT,
    status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (carrier_id) REFERENCES carriers(carrier_id),
    FOREIGN KEY (origin_hub_id) REFERENCES hubs(hub_id),
    FOREIGN KEY (destination_hub_id) REFERENCES hubs(hub_id)
);

CREATE TABLE delivery_events (
    event_id INT PRIMARY KEY,
    shipment_id INT,
    event_name VARCHAR(100),
    event_date DATE,
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id)
);
INSERT INTO customers VALUES
(101, 'Arun Enterprises', 'Chennai'),
(102, 'Priya Traders', 'Coimbatore'),
(103, 'Global Retail', 'Bangalore'),
(104, 'Fresh Foods', 'Hyderabad'),
(105, 'Tech Solutions', 'Mumbai');
INSERT INTO carriers VALUES
(201, 'BlueDart'),
(202, 'Delhivery'),
(203, 'DTDC'),
(204, 'FedEx');
INSERT INTO hubs VALUES
(301, 'Chennai Hub', 'Chennai'),
(302, 'Coimbatore Hub', 'Coimbatore'),
(303, 'Bangalore Hub', 'Bangalore'),
(304, 'Mumbai Hub', 'Mumbai'),
(305, 'Delhi Hub', 'Delhi');
INSERT INTO employees VALUES
(401, 'Ravi', 301, NULL);

INSERT INTO employees VALUES
(402, 'Priya', 301, 401),
(403, 'Karthik', 302, 401),
(404, 'Divya', 303, 401),
(405, 'Arun', 304, 402);
INSERT INTO shipments VALUES
(1001, 101, 201, 301, 304, 500, 2, 'Delivered'),
(1002, 102, 202, 302, 301, 750, 4, 'Delayed'),
(1003, 101, 203, 301, 303, 600, 1, 'Delivered'),
(1004, 103, 201, 303, 305, 900, 5, 'Delayed'),
(1005, 102, 202, 302, 304, 800, 3, 'Delivered'),
(1006, 104, 203, 301, 302, 450, 0, 'Delivered'),
(1007, 105, 204, 304, 305, 1200, 6, 'Delayed'),
(1008, 103, 201, 303, 301, 650, 2, 'Delivered');
INSERT INTO delivery_events VALUES
(1, 1001, 'Picked Up', '2026-11-10'),
(2, 1001, 'In Transit', '2026-11-11'),
(3, 1001, 'Delivered', '2026-11-12'),

(4, 1002, 'Picked Up', '2026-11-10'),
(5, 1002, 'Delayed at Hub', '2026-11-13'),

(6, 1003, 'Delivered', '2026-11-11'),

(7, 1004, 'Picked Up', '2026-11-10'),
(8, 1004, 'Out for Delivery', '2026-11-15'),

(9, 1005, 'Delivered', '2026-11-14'),

(10, 1006, 'Picked Up', '2026-11-12'),
(11, 1006, 'Delivered', '2026-11-13'),

(12, 1007, 'Picked Up', '2026-11-12'),
(13, 1007, 'Delayed at Hub', '2026-11-16'),

(14, 1008, 'Picked Up', '2026-11-13'),
(15, 1008, 'Delivered', '2026-11-14');
UPDATE shipments
SET shipping_cost = 550
WHERE shipment_id = 1001;
UPDATE shipments
SET status = 'Delivered',
    delay_days = 2
WHERE shipment_id = 1002;
DELETE FROM delivery_events
WHERE event_id = 15;
ALTER TABLE shipments
ADD COLUMN shipment_priority VARCHAR(20) DEFAULT 'Normal';
ALTER TABLE shipments
MODIFY shipping_cost DECIMAL(12,2);
SELECT s.shipment_id,
       c.customer_name,
       cr.carrier_name,
       s.shipping_cost,
       s.status
FROM shipments s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
INNER JOIN carriers cr
    ON s.carrier_id = cr.carrier_id;
SELECT c.customer_id,
       c.customer_name,
       s.shipment_id
FROM customers c
LEFT JOIN shipments s
    ON c.customer_id = s.customer_id;
SELECT h.hub_id, h.hub_name
FROM hubs h
LEFT JOIN shipments s
    ON h.hub_id = s.origin_hub_id
WHERE s.shipment_id IS NULL;
SELECT e.employee_name AS employee,
       m.employee_name AS supervisor
FROM employees e
LEFT JOIN employees m
    ON e.supervisor_id = m.employee_id;
SELECT s.shipment_id,
       origin.hub_name AS origin_hub,
       destination.hub_name AS destination_hub,
       s.status
FROM shipments s
INNER JOIN hubs origin
    ON s.origin_hub_id = origin.hub_id
INNER JOIN hubs destination
    ON s.destination_hub_id = destination.hub_id;
SELECT s.shipment_id,
       c.customer_name,
       cr.carrier_name,
       s.delay_days
FROM shipments s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
INNER JOIN carriers cr
    ON s.carrier_id = cr.carrier_id
WHERE s.delay_days > 2;
SELECT c.customer_id,
       c.customer_name,
       s.shipment_id
FROM customers c
LEFT JOIN shipments s
    ON c.customer_id = s.customer_id

UNION

SELECT c.customer_id,
       c.customer_name,
       s.shipment_id
FROM customers c
RIGHT JOIN shipments s
    ON c.customer_id = s.customer_id;
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM shipments
);
SELECT c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM shipments s
    WHERE s.customer_id = c.customer_id
);
SELECT shipment_id, shipping_cost
FROM shipments
WHERE shipping_cost > ANY (
    SELECT shipping_cost
    FROM shipments
    WHERE origin_hub_id = 301
);
SELECT shipment_id, shipping_cost
FROM shipments
WHERE shipping_cost > ALL (
    SELECT shipping_cost
    FROM shipments
    WHERE origin_hub_id = 301
);
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM shipments
);
SELECT DISTINCT c.customer_name
FROM customers c
INNER JOIN shipments s
    ON c.customer_id = s.customer_id;
SELECT origin_hub_id, MAX(shipping_cost) AS second_highest_cost
FROM shipments
WHERE shipping_cost < (
    SELECT MAX(shipping_cost)
    FROM shipments s2
    WHERE s2.origin_hub_id = shipments.origin_hub_id
)
GROUP BY origin_hub_id;
SELECT cr.carrier_name,
       COUNT(s.shipment_id) AS total_shipments
FROM carriers cr
LEFT JOIN shipments s
    ON cr.carrier_id = s.carrier_id
GROUP BY cr.carrier_id, cr.carrier_name;
SELECT cr.carrier_name,
       AVG(s.delay_days) AS average_delay
FROM carriers cr
INNER JOIN shipments s
    ON cr.carrier_id = s.carrier_id
GROUP BY cr.carrier_id, cr.carrier_name;

SELECT carrier_name
FROM carriers
WHERE carrier_id IN (
    SELECT carrier_id
    FROM shipments
    GROUP BY carrier_id
    HAVING AVG(delay_days) > (
        SELECT AVG(delay_days)
        FROM shipments
    )
);






    








