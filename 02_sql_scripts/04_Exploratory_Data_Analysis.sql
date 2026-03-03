/* ============================================================================
   PROJECT: OLIST SUPPLY CHAIN & E-COMMERCE ANALYTICS
   SCRIPT: 04_Exploratory_Data_Analysis.sql
   AUTHOR: Aaron Olmedo 
   DESCRIPTION: 
   Initial data exploration to understand order statuses and calculate 
   delivery delays. This sets the foundation for our Power BI dashboard.
============================================================================ */

USE olist_supply_chain;
GO

-- 1. Analyze Order Status Distribution
SELECT 
	COUNT(*) AS Total_Orders,
	COUNT(CASE WHEN order_status = 'delivered' THEN 1 END) AS Delivered,
	COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) AS Canceled
FROM olist_orders_dataset

-- INSIGHT: Out of 99,441 total orders, 96,478 were delivered. 

-- 2.Total Revenue and Average Item Price
SELECT 
	ROUND(SUM(i.price),2)AS Total_Revenue_Sales,
	ROUND(AVG(i.price),2) AS Average_Item_Price 
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
);

-- INSIGHT: Delivered orders generated a total revenue of ~13.22M, with an average item price of ~119.98.

-- 3. ow many delivered orders were LATE?
SELECT
	COUNT(*) AS Total_Late_Delivered_Orders,
	CAST(
        ROUND(COUNT(*)*100.0/ (SELECT COUNT(*) FROM olist_orders_dataset), 2)
       AS DECIMAL(5,2)) AS Percentage_of_Late_Delivered_Orders
FROM olist_orders_dataset 
WHERE 
	order_status = 'delivered'
	AND order_delivered_customer_date > order_estimated_delivery_date;

	-- INSIGHT: 7,826 orders arrived late, which represents 7.87% of all successfully delivered orders.

-- 4. Which states have the most late deliveries?
SELECT 
	c.customer_state AS customer_state,
    COUNT(o.order_id) AS total_late_orders
FROM 
    olist_orders_dataset o
JOIN 
    olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE 
    o.order_status = 'delivered' 
    AND o.order_delivered_customer_date > o.order_estimated_delivery_date
GROUP BY 
    c.customer_state
ORDER BY 
    total_late_orders DESC;

-- INSIGHT: São Paulo (SP), Rio de Janeiro (RJ), and Minas Gerais (MG) are the biggest logistical bottlenecks, 
-- holding the vast majority of late deliveries.

-- 5. Average freight value per state
SELECT 
    c.customer_state AS customer_state,
    ROUND(AVG(i.freight_value), 2) AS avg_freight_value
FROM 
    olist_orders_dataset o
JOIN 
    olist_customers_dataset c ON o.customer_id = c.customer_id
JOIN 
    olist_order_items_dataset i ON o.order_id = i.order_id
GROUP BY 
    c.customer_state
ORDER BY 
    avg_freight_value DESC;

-- INSIGHT: Northern states like RR, PB, and RO pay the highest freight costs (> 40), 
-- while SP pays the lowest (15.15). The logistics strategy must differ by region.

-- 6. Impact of late deliveries on review scores
SELECT 
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late Delivery'
        ELSE 'On Time Delivery'
    END AS delivery_performance,
    ROUND(AVG(CAST(r.review_score AS FLOAT)), 2) AS avg_review_score,
    COUNT(o.order_id) AS total_reviews
FROM 
    olist_orders_dataset o
JOIN 
    olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late Delivery'
        ELSE 'On Time Delivery'
 

 -- INSIGHT: Logistics directly impact brand reputation. On-time deliveries average an excellent 4.29 stars, 
 -- while late deliveries plummet to a poor 2.57 stars.

 END;