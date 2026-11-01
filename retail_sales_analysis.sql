SELECT COUNT(*) AS total_customers
FROM customers;
SELECT COUNT(*) AS total_products
FROM products;
SELECT COUNT(*) AS total_orders
FROM orders;
SELECT
    SUM(p.price * oi.quantity) AS delivered_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'Delivered';
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * oi.quantity) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_sold,
    SUM(p.price * oi.quantity) AS total_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 5;
SELECT
    c.customer_name,
    SUM(p.price * oi.quantity) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC
LIMIT 5;
SELECT
    p.product_name,
    SUM((p.price - p.cost) * oi.quantity) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC;
