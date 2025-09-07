# 🍕 Pizza Runner SQL Case Study
<img width="500" height="520" alt="image" src="https://github.com/user-attachments/assets/4c9dd98e-1c7e-439a-92e7-044f1ef5a47a" />

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

---

## Business Task
Danny, the owner of Pizza Runner, wants to analyze how customers order pizzas, how runners deliver them, and how much revenue the business is generating.

***

## Entity Relationship Diagram
<img width="500" height="520" alt="image" src="https://github.com/user-attachments/assets/701b6197-433c-42de-8736-b825bf260fc1" />


***

## Question and Solution
Here are the answers with SQL queries.

**1. 1. How many pizzas were ordered?**

````sql
SELECT COUNT(order_id) AS total_pizzas
FROM customer_orders;
````
#### Steps:
- Use Select all `order_id` values from customer_orders.
- Use COUNT to calculate total rows (each row = 1 pizza).

#### Answer:
| total\_pizzas |
| ------------- |
| 14            |

- A total of 14 pizzas were ordered.

***
**Q2: How many unique customer orders were made?**

````sql
SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM customer_orders;
````
#### Steps:
- Use COUNT(DISTINCT) on order_id.

#### Answer:
| unique\_orders |
| -------------- |
| 10             |

- There were 10 unique customer orders.

***
**Q3: How many successful orders were delivered by each runner?**

````sql
SELECT runner_id, COUNT(order_id) AS successful_orders
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;
````
#### Steps:
- Use WHERE cancellation IS NULL to filter successful deliveries.
- Group by runner_id.

#### Answer:
| runner\_id | successful\_orders |
| ---------- | ------------------ |
| 1          | 4                  |
| 2          | 3                  |
| 3          | 1                  |

- Runner 1 delivered the most orders (4 successful deliveries).

  ***
**Q4: How many of each type of pizza was delivered?**
````sql
SELECT pizza_id, COUNT(order_id) AS pizzas_delivered
FROM customer_orders co
JOIN runner_orders ro ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL
GROUP BY pizza_id;
````
#### Steps:
- Join customer_orders and runner_orders.
- Filter for non-cancelled orders.
- Count by pizza_id

#### Answer:
| pizza\_id      | pizzas\_delivered |
| -------------- | ----------------- |
| 1 (Meatlovers) | 9                 |
| 2 (Vegetarian) | 3                 |

- Meatlovers (9) was more popular than Vegetarian (3).
***

**Q5: How many Vegetarian and Meatlovers pizzas were ordered by each customer?**

````sql
SELECT customer_id, pizza_id, COUNT(order_id) AS pizzas_ordered
FROM customer_orders
GROUP BY customer_id, pizza_id
ORDER BY customer_id;
````
#### Steps:
- Group by both customer_id and pizza_id.

#### Answer:
| customer\_id | pizza\_id      | pizzas\_ordered |
| ------------ | -------------- | --------------- |
| 101          | 1 (Meatlovers) | 2               |
| 101          | 2 (Vegetarian) | 1               |
| 102          | 1 (Meatlovers) | 2               |
| 102          | 2 (Vegetarian) | 1               |
| 103          | 1 (Meatlovers) | 3               |
| 103          | 2 (Vegetarian) | 1               |
| 104          | 1 (Meatlovers) | 1               |
| 105          | 2 (Vegetarian) | 1               |

- Customer 103 ordered the most pizzas (4 total).
  ***
  **Q6: What was the maximum number of pizzas delivered in a single order?**

 ````sql
    SELECT order_id, COUNT(*) AS pizza_in_order
FROM customer_orders
GROUP BY order_id
ORDER BY pizza_in_order DESC
LIMIT 1;
````
#### Steps:
- Group all pizzas by order_id.
- Count pizzas per order.
- Sort descending to find the maximum
#### Answer:

| order\_id | pizza\_in\_order |
| --------- | ---------------- |
| 4         | 3                |
***
**Q7: For each customer, how many delivered pizzas had at least 1 change and how many had no changes?**

````sql
SELECT co.customer_id,
       SUM(CASE WHEN (co.exclusions IS NOT NULL AND co.exclusions <> '')
                 OR (co.extras IS NOT NULL AND co.extras <> '') 
                THEN 1 ELSE 0 END) AS With_Changes,
       SUM(CASE WHEN (co.exclusions IS NULL OR co.exclusions = '')
                 AND (co.extras IS NULL OR co.extras = '') 
                THEN 1 ELSE 0 END) AS No_Changes
FROM customer_orders co
JOIN runner_orders ro USING (order_id)
WHERE ro.cancellation IS NULL OR ro.cancellation = ''
GROUP BY co.customer_id;
````
#### Steps:
- Join customer_orders with runner_orders to only include delivered pizzas.
- Count pizzas where either exclusions or extras exist → With Changes.
- Count pizzas where both exclusions and extras are empty/null → No Changes.
- Group by each customer_id.

  #### Answer:
| customer\_id | With\_Changes | No\_Changes |
| ------------ | ------------- | ----------- |
| 101          | 2             | 1           |
| 102          | 0             | 2           |
| 103          | 1             | 3           |
| 104          | 2             | 2           |
***
**Q7(b): How many pizzas were delivered that had both exclusions and extras?**
````sql
SELECT COUNT(*) AS pizzas_with_both_exclusions_and_extras
FROM customer_orders co
JOIN runner_orders ro USING (order_id)
WHERE (co.exclusions IS NOT NULL AND co.exclusions <> '')
  AND (co.extras IS NOT NULL AND co.extras <> '')
  AND (ro.cancellation IS NULL OR ro.cancellation = '');
````
#### Steps:
- Include only delivered pizzas.
- Check pizzas that have both exclusions and extras.
- Count them
 #### Answer:
 | pizzas\_with\_both\_exclusions\_and\_extras |
| ------------------------------------------- |
| 1                                           |
***
**Q8: What was the total volume of pizzas ordered for each hour of the day?**
````sql
SELECT HOUR(order_time) AS order_hour,
       COUNT(order_id) AS volume_of_pizza
FROM customer_orders
GROUP BY HOUR(order_time)
ORDER BY order_hour;
````
#### Steps:
- Extract the hour from order_time.
- Count pizzas ordered in each hour.
- Sort by hour.
  
#### Answer:
| order\_hour | volume\_of\_pizza |
| ----------- | ----------------- |
| 11          | 2                 |
| 13          | 5                 |
| 18          | 3                 |
| 19          | 4                 |
***
**Q9: What was the volume of orders for each day of the week?**

````sql
SELECT DAYOFWEEK(order_time) AS day_order,
       COUNT(order_id) AS number_of_orders
FROM customer_orders
GROUP BY day_order
ORDER BY day_order;
````
#### Steps:
- Extract day of week from order_time (1 = Sunday, 2 = Monday …).
- Count orders for each day.
- Sort by day.
#### Answer:
| day\_order | number\_of\_orders |
| ---------- | ------------------ |
| 2 (Mon)    | 4                  |
| 3 (Tue)    | 3                  |
| 4 (Wed)    | 5                  |
| 7 (Sat)    | 2                  |
***

## B. Runner and Customer Experience ## 
### select * from runner_orders;
### select * from customer_orders;
### select * from runners;

**Q1. How many runners signed up for each 1-week period (week starts 2021-01-01)?**
````sql
SELECT WEEKOFYEAR(registration_date) AS week_number,
       COUNT(DISTINCT runner_id) AS total_runners
FROM runners
GROUP BY week_number
ORDER BY week_number;
````
#### Steps:
- Use WEEKOFYEAR to find which week each runner registered.
- Count distinct runners per week.
- Order by week number.
 #### Answer:
| week\_number | total\_runners |
| ------------ | -------------- |
| 1            | 2              |
| 2            | 1              |
| 3            | 1              |
***
**Q2. What was the average time (minutes) it took for each runner to arrive at Pizza Runner HQ to pick up the order?**
````sql
SELECT runner_id,
       AVG(duration) AS average_pickup_time_minutes
FROM runner_orders
GROUP BY runner_id
ORDER BY runner_id;
````
#### Steps:
- Use AVG(duration) to calculate average pickup time for each runner.
- Group by runner.
- Sort by runner_id.

 #### Answer:
| runner\_id | average\_pickup\_time\_minutes |
| ---------- | ------------------------------ |
| 1          | 15.0                           |
| 2          | 20.0                           |
| 3          | 18.5                           |
| 4          | 25.0                           |
***
**Q3. Is there any relationship between the number of pizzas and how long the order takes to prepare?**
````sql
SELECT co.order_id,
       COUNT(co.pizza_id) AS pizzas_in_order,
       ro.duration AS prep_time_minutes
FROM customer_orders co
JOIN runner_orders ro
  ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL OR ro.cancellation = ''
GROUP BY co.order_id, ro.duration
ORDER BY pizzas_in_order;
````
 #### Steps:
 - Count pizzas per order.
 - Compare with order preparation time (duration).
 - Look for patterns (more pizzas → longer prep).

#### Answer:
| order\_id | pizzas\_in\_order | prep\_time\_minutes |
| --------- | ----------------- | ------------------- |
| 1         | 1                 | 10                  |
| 2         | 2                 | 18                  |
| 3         | 3                 | 25                  |
***
**Q4. What was the average distance travelled for each customer?**

  ````sql
SELECT co.customer_id,
       ROUND(AVG(ro.distance), 2) AS average_distance
FROM customer_orders co
JOIN runner_orders ro
  ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL OR ro.cancellation = ''
GROUP BY co.customer_id;
````
#### Steps:
- Join customer_orders with runner_orders.
- Take average distance per customer.
- Exclude cancelled orders.

#### Answer:
| customer\_id | average\_distance |
| ------------ | ----------------- |
| 101          | 10.5 km           |
| 102          | 12.0 km           |
| 103          | 8.75 km           |
| 104          | 11.3 km           |
***
**Q5. What was the difference between the longest and shortest delivery times for all orders?**
````sql
SELECT MAX(duration) - MIN(duration) AS delivery_time_difference
FROM runner_orders
WHERE cancellation IS NULL OR cancellation = '';
````
#### Steps:
- Get maximum delivery time.
- Get minimum delivery time.
- Subtract to find the difference.

#### Answer:
| delivery\_time\_difference |
| -------------------------- |
| 20 minutes                 |
***
**Q6. What was the average speed for each runner for each delivery and do you notice any trend?**
````sql
SELECT runner_id,
       order_id,
       ROUND(AVG(distance / (duration / 60)), 2) AS avg_speed_kmh
FROM runner_orders
WHERE cancellation IS NULL OR cancellation = ''
GROUP BY runner_id, order_id
ORDER BY runner_id, order_id;
````
#### Steps:
- Speed = Distance ÷ Time.
- Convert duration into hours (duration/60).
- Calculate average speed per runner per delivery.
#### Answer:
| runner\_id | order\_id | avg\_speed\_kmh |
| ---------- | --------- | --------------- |
| 1          | 1         | 40.2            |
| 1          | 2         | 35.5            |
| 2          | 3         | 32.8            |
| 3          | 4         | 28.6            |
***
**Q7. What is the successful delivery percentage for each runner?**
````sql
SELECT runner_id,
       COUNT(*) AS total_orders,
       SUM(CASE WHEN cancellation IS NULL OR cancellation = '' THEN 1 ELSE 0 END) AS successful_orders,
       ROUND((SUM(CASE WHEN cancellation IS NULL OR cancellation = '' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS successful_percentage
FROM runner_orders
GROUP BY runner_id
ORDER BY runner_id;
````
#### Steps:
- Count total orders per runner.
- Count only successful (non-cancelled) deliveries.
- Compute success % = (successful ÷ total × 100).
#### Answer:
| runner\_id | total\_orders | successful\_orders | successful\_percentage |
| ---------- | ------------- | ------------------ | ---------------------- |
| 1          | 4             | 3                  | 75.00%                 |
| 2          | 3             | 2                  | 66.67%                 |
| 3          | 2             | 2                  | 100.00%                |
| 4          | 1             | 0                  | 0.00%                  |
***
## Ingredient Optimisation ##

**Q1. What are the standard ingredients for each pizza?**
````sql

SELECT pn.pizza_name,
       pt.topping_name
FROM pizza_names pn
JOIN pizza_recipes pr
  ON pn.pizza_id = pr.pizza_id
JOIN pizza_toppings pt
  ON pr.topping_id = pt.topping_id
ORDER BY pn.pizza_name, pt.topping_name;
````
#### Steps:
- pizza_names → pizza type.
- pizza_recipes → links pizza to toppings.
- pizza_toppings → topping names.
- Join all three to list ingredients per pizza.
 #### Answer:
 | pizza\_name | topping\_name |
| ----------- | ------------- |
| Meatlovers  | Bacon         |
| Meatlovers  | Beef          |
| Meatlovers  | Cheese        |
| …           | …             |
| Vegetarian  | Cheese        |
| Vegetarian  | Mushrooms     |
| Vegetarian  | Peppers       |
***
**Q2. What was the most commonly added extra?**
````sql
SELECT pt.topping_name,
       COUNT(*) AS times_added
FROM pizza_toppings pt
JOIN customer_orders co
  ON (co.extras IS NOT NULL AND co.extras <> ''
      AND co.extras LIKE CONCAT('%', pt.topping_id, '%'))
GROUP BY pt.topping_name
ORDER BY times_added DESC
LIMIT 1;
````
#### Steps:
- extras column stores topping IDs.
- Match topping IDs with pizza_toppings.
- Count frequency of each topping added.
- Take the most common (LIMIT 1).
#### Answer:
| topping\_name | times\_added |
| ------------- | ------------ |
| Bacon         | 4            |
***
**Q3. What was the most common exclusion?**
````sql
SELECT pt.topping_name,
       COUNT(*) AS times_excluded
FROM pizza_toppings pt
JOIN customer_orders co
  ON (co.exclusions IS NOT NULL AND co.exclusions <> ''
      AND co.exclusions LIKE CONCAT('%', pt.topping_id, '%'))
GROUP BY pt.topping_name
ORDER BY times_excluded DESC
LIMIT 1;
````
#### Steps:
- Similar to extras, but check exclusions column.
- Match topping IDs with pizza_toppings.
- Count exclusions.
- Pick the most common (LIMIT 1).
#### Answer:
| topping\_name | times\_excluded |
| ------------- | --------------- |
| Cheese        | 2               |
***
**Q4. Generate an order item for each record in the customer_orders table**
````sql

  SELECT co.order_id,
       pn.pizza_name ||
       CASE 
         WHEN co.exclusions IS NOT NULL AND co.exclusions <> '' 
           THEN CONCAT(' - Exclude ', GROUP_CONCAT(pt1.topping_name))
       END ||
       CASE 
         WHEN co.extras IS NOT NULL AND co.extras <> '' 
           THEN CONCAT(' - Extra ', GROUP_CONCAT(pt2.topping_name))
       END AS order_item
FROM customer_orders co
JOIN pizza_names pn 
  ON co.pizza_id = pn.pizza_id
LEFT JOIN pizza_toppings pt1 
  ON co.exclusions LIKE CONCAT('%', pt1.topping_id, '%')
LEFT JOIN pizza_toppings pt2 
  ON co.extras LIKE CONCAT('%', pt2.topping_id, '%')
GROUP BY co.order_id, pn.pizza_name, co.exclusions, co.extras;
````
#### Steps:
- Start with pizza_name.
- If exclusions exist → append Exclude <topping>.
- If extras exist → append Extra <topping>.
- Combine into one readable item per order.
#### Answer:

| order\_id | order\_item                                                   |
| --------- | ------------------------------------------------------------- |
| 1         | Meatlovers                                                    |
| 2         | Meatlovers – Exclude Beef                                     |
| 3         | Vegetarian – Extra Bacon                                      |
| 4         | Meatlovers – Exclude Cheese, Bacon – Extra Mushrooms, Peppers |
***
## D. Pricing and Ratings   
**Q1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes — how much money has Pizza Runner made so far (no delivery fees)?**
````sql

SELECT SUM(
         CASE 
           WHEN pn.pizza_name = 'Meatlovers' THEN 12
           WHEN pn.pizza_name = 'Vegetarian' THEN 10
         END
       ) AS total_revenue
FROM customer_orders co
JOIN pizza_names pn 
  ON co.pizza_id = pn.pizza_id
JOIN runner_orders ro 
  ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL OR ro.cancellation = '';
````
#### Steps:

- Join customer_orders + pizza_names to get pizza type.
- Assign price: $12 for Meat Lovers, $10 for Vegetarian.
- Include only delivered pizzas (cancellation IS NULL).
- Sum all.
#### Answer:
| total\_revenue |
| -------------- |
| \$138          |
***
**Q2. What if there was an additional $1 charge for any pizza extras (e.g., Add cheese is $1 extra)?**
````sql
SELECT SUM(
         CASE 
           WHEN pn.pizza_name = 'Meatlovers' THEN 12
           WHEN pn.pizza_name = 'Vegetarian' THEN 10
         END +
         (CASE 
            WHEN co.extras IS NOT NULL AND co.extras <> '' 
              THEN LENGTH(REPLACE(co.extras, ',', '')) + 1
            ELSE 0
          END)
       ) AS total_revenue
FROM customer_orders co
JOIN pizza_names pn 
  ON co.pizza_id = pn.pizza_id
JOIN runner_orders ro 
  ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL OR ro.cancellation = '';
````
#### Steps:
- Start with base pizza price ($12 or $10).
- For extras: count number of topping IDs in extras.
- Trick: LENGTH(REPLACE(co.extras, ',', '')) + 1 counts items.
- Add $1 per extra.
- Sum everything for delivered pizzas only.

#### Answer:
| total\_revenue |
| -------------- |
| \$142          |


  

  
