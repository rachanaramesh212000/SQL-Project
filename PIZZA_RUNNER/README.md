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
