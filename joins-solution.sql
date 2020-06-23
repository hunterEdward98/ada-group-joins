-- Get all customers and their addresses.
SELECT customers.first_name, customers.last_name, addresses.street
FROM customers
    JOIN addresses ON addresses.id = customers.id;

-- Get all orders and their line items (orders, quantity and product).
SELECT orders, products.description, line_items.quantity
FROM orders
    JOIN line_items ON orders.id = line_items.order_id
    JOIN products ON products.id = line_items.product_id;

-- Which warehouses have cheetos?
SELECT warehouse.warehouse
FROM warehouse
    JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
    JOIN products ON warehouse_product.product_id = products.id
WHERE products.description
ilike '%Cheeto%' AND warehouse_product.on_hand !=0;

-- Which warehouses have diet pepsi?
SELECT warehouse.warehouse
FROM warehouse
    JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
    JOIN products ON warehouse_product.product_id = products.id
WHERE products.description = 'diet pepsi' AND warehouse_product.on_hand !=0;

-- Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT customers.first_name, count(orders)
FROM customers
    JOIN addresses ON customers.id = addresses.customer_id
    JOIN orders ON orders.address_id = addresses.id
GROUP BY customers.first_name;

--How many customers do we have?
SELECT count(customers)
FROM customers;

-- How many products do we carry?
SELECT count(products)
FROM products;

--What is the total available on-hand quantity of diet pepsi?
SELECT sum(warehouse_product.on_hand)
from warehouse_product
    JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'diet pepsi';

--Stretch
--How much was the total cost for each order?
SELECT orders.id, sum(products.unit_price)
FROM orders
    JOIN line_items ON orders.id = line_items.order_id
    JOIN products ON products.id = line_items.product_id
GROUP BY orders.id;

--How much has each customer spent in total?
SELECT customers.first_name, sum(products.unit_price)
FROM customers
    JOIN addresses ON customers.id = addresses.customer_id
    JOIN orders ON orders.address_id = addresses.id
    JOIN line_items ON orders.id = line_items.order_id
    JOIN products ON products.id = line_items.product_id
GROUP BY customers.first_name;

--