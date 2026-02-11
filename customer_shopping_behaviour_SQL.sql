-- TOTAL REVENUE GENERATED, MALE VS FEMALE CUSTOMERS
SELECT gender, SUM(purchase_amount) as revenue
FROM customer
GROUP BY gender

-- customers using discount cpde but still spent nore than the average purchase amount
SELECT customer_id, purchase_amount
FROM customer 
WHERE discount_applied = 'Yes' AND purchase_amount > (SELECT AVG(purchase_amount) FROM customer);

-- top 5 products with the highest review ratings
SELECT item_purchased, ROUND(AVG(review_rating::numeric),2) AS "Average_Product_Rating"
FROM customer
GROUP BY item_purchased
ORDER BY AVG(review_rating) DESC
LIMIT 5;

-- Standard VS express shipping average purchase amounts
SELECT shipping_type, ROUND(AVG(purchase_amount),2) AS "Average Purchase Amount"
FROM customer
WHERE shipping_type in ('Standard', 'Express')
GROUP BY shipping_type;

-- average spend and total revenue between subscribers and non-subscribers
SELECT subscription_status,
       COUNT(customer_id) AS total_customers,
       ROUND(AVG(purchase_amount),2) AS avg_spend,
       ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer
GROUP BY subscription_status
ORDER BY total_revenue,avg_spend DESC;

-- top 4 products with the highest percentage of purchases with discounts apllied
SELECT item_purchased,
       ROUND(100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

-- repeat buyers, more than 5 purchases
 SELECT subscription_status,      
	   COUNT(customer_id) AS repeat_buyers
FROM customer
WHERE previous_purchases > 5
GROUP BY subscription_status;

-- revenue contribution per age group
SELECT 
    age_group,
    SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY age_group
ORDER BY total_revenue desc;