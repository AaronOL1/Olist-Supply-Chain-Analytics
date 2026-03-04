# 📦 Olist Supply Chain Analytics: E-commerce Logistics Optimization

> **An End-to-End Data Engineering and Business Intelligence Project**

## 📌 Project Overview
In the highly competitive e-commerce sector, last-mile delivery and supply chain efficiency are the primary drivers of customer retention. Late deliveries directly correlate with negative reviews, increased return rates, and significant revenue loss.

This project analyzes a real-world, highly relational database of over **100,000 orders** from **Olist**, the largest department store in Brazilian marketplaces. By processing and integrating 9 interconnected datasets (orders, customers, payments, reviews, and geolocation), this project builds a robust analytical foundation to uncover logistical bottlenecks and optimize freight performance.

## 🏗️ Phase 1: Data Architecture & Engineering (Completed)
To extract actionable insights from raw transactional data, the first phase focused on transforming the dataset into a business-ready model.

* **ETL Pipeline:** Extracted raw CSV files, handled missing values, standardized complex Brazilian geolocation data, and formatted timestamps for accurate time-intelligence calculations.
* **Dimensional Modeling:** Engineered a robust **Star Schema** to ensure optimal query performance and seamless filtering across multiple business dimensions.

## 📊 Phase 2: Business Intelligence Dashboard (Upcoming)
The next phase focuses on visualizing the data through an interactive dashboard to drive strategic decision-making. The upcoming visualizations will target the following business objectives:

* **Logistics Performance Tracking:** Measuring the "On-Time Delivery Rate" and calculating the average delay (in days) using advanced DAX Time Intelligence measures.
* **Geospatial Bottleneck Analysis:** Identifying the specific Brazilian states, cities, and freight routes that consistently cause the most severe logistical delays.
* **Root Cause & Impact Analysis:** Correlating delivery delays with customer review scores to quantify the actual business and financial impact of logistical failures.
* **Freight Cost Optimization:** Analyzing the relationship between freight value, delivery time, and geographic regions.

## 🛠️ Tech Stack
* **Data Transformation (ETL):** SQL / Power Query (M Language)
* **Data Modeling:** Power BI (Star Schema / Dimensional Modeling)
* **Analytics & KPIs:** DAX (Data Analysis Expressions)
* **Data Source:** Kaggle / Olist E-commerce Dataset
