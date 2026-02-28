/*    
   SCRIPT: 03_Data_Modeling_Constraints.sql
   AUTHOR: Aaron Olmedo
   DESCRIPTION: 
   This script alters the existing tables to add FOREIGN KEY constraints.
   It transforms isolated tables into a relational Star Schema, ensuring 
   referential integrity.
*/

-- 1. Link Orders to Customers
-- (An order cannot exist without a valid customer)
ALTER TABLE olist_orders_dataset
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (customer_id) REFERENCES olist_customers_dataset(customer_id);
GO

-- 2. Link Order Items to Orders
-- (Items must belong to a valid order)
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT FK_Items_Orders
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);
GO

-- 3. Link Order Items to Products
-- (You can't sell a product that isn't in the catalog)
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT FK_Items_Products
FOREIGN KEY (product_id) REFERENCES olist_products_dataset(product_id);
GO

-- 4. Link Order Items to Sellers
-- (Items must be sold by a registered seller)
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT FK_Items_Sellers
FOREIGN KEY (seller_id) REFERENCES olist_sellers_dataset(seller_id);
GO

-- 5. Link Reviews to Orders
-- (A review must be attached to a real order)
ALTER TABLE olist_order_reviews_dataset
ADD CONSTRAINT FK_Reviews_Orders
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);
GO

-- 6. Link Payments to Orders
ALTER TABLE olist_order_payments_dataset
ADD CONSTRAINT FK_Payments_Orders
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);
GO