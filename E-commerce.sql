--- Create database
CREATE DATABASE BRAZILIAN_ECOMMERCE;
 
--- Use as BRAZILIAN_ECOMMERCE default schema
USE BRAZILIAN_ECOMMERCE;

--- What are the top 10 cities and states with the highest number of customers?
SELECT TOP 10
	customer_city,
	customer_state,
	COUNT(*) AS city_count
FROM 
	olist_customers_dataset
GROUP BY	
	customer_city, 
	customer_state
ORDER BY 3 DESC;

--- How many orders were placed daily?
SELECT 
	order_purchase_timestamp,
	COUNT(*) AS daily_orders
FROM 
	olist_orders_dataset
GROUP BY
	order_purchase_timestamp
ORDER BY 
	2 DESC;

--- What are the top-selling products?
SELECT 
	column2,
	COUNT(*) AS count_orders
FROM 
	olist_products_dataset p
JOIN 
	olist_order_items_dataset o
ON
	p.product_id = o.product_id
JOIN 
	product_category_name_translation pt
ON
	p.product_category_name = pt.column1
GROUP BY
	column2
ORDER BY 
	2 DESC;

--- What is the date difference between estimated delivery and actual delivery dates?
SELECT 
    order_id,
    order_status,
    order_delivered_customer_date, 
    order_estimated_delivery_date,
    DATEDIFF(DAY, order_delivered_customer_date, order_estimated_delivery_date) AS date_difference
FROM 
    olist_orders_dataset
WHERE 
    order_status = 'delivered';

---How many orders were delivered late?
SELECT 
	COUNT(*) AS orders_delivered_late
FROM 
	olist_orders_dataset 
WHERE 
	order_delivered_customer_date > order_estimated_delivery_date;


--- What is the average monthly delivery time?
SELECT 
	MONTH(order_purchase_timestamp) AS order_month,
	YEAR(order_purchase_timestamp) AS order_year,
    AVG(DATEDIFF(DAY, order_delivered_customer_date, order_estimated_delivery_date)) AS avg_monthly_delivery
FROM 
    olist_orders_dataset
WHERE 
    order_status = 'delivered'
	AND order_delivered_customer_date <> ' '
GROUP BY   YEAR(order_purchase_timestamp), 
    MONTH(order_purchase_timestamp)
ORDER BY
	1 ASC;


-- How can we retrieve orders by month and year?
SELECT 
    MONTH(order_purchase_timestamp) AS order_month,
	YEAR(order_purchase_timestamp) AS order_year,
    COUNT(*) AS total_orders
FROM 
    olist_orders_dataset 
	GROUP BY 
    MONTH(order_purchase_timestamp),
	YEAR(order_purchase_timestamp)
	ORDER BY 3 DESC;


--- What is the average review score for products?
SELECT 
	column2, 
	AVG(review_score) AS avg_review_score
FROM 
	olist_products_dataset pd
JOIN 
	olist_order_items_dataset oi
ON 
	pd.product_id = oi.product_id
JOIN 
	olist_order_reviews_dataset oo
ON 
	oo.order_id = oi.order_id
JOIN 
	product_category_name_translation pn
ON 
	pd.product_category_name = pn.column1
GROUP BY 
	column2
ORDER BY
	2 DESC;

--- What is the distribution of orders by payment type?
SELECT 
	payment_type,
	COUNT(*) AS orders
FROM 
	olist_order_payments_dataset
GROUP BY 
	payment_type
ORDER BY 
	2 DESC;

---What is the average shipping cost?
SELECT 
	AVG(Freight_value) AS avg_shipping_cost
FROM 
	olist_order_items_dataset;


---Who are the top 10 sellers by sales volume?
SELECT 
	TOP 10
	seller_id,
	SUM(price) AS total_sales
FROM 
	olist_order_items_dataset
GROUP BY 
	seller_id
ORDER BY 
	2 DESC;


