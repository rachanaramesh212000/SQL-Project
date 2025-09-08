# 🍽️ Foodie-Fi
<img width="500" height="525" alt="Image" src="https://github.com/user-attachments/assets/99f5e751-b80b-4cf6-aade-0806acbd1b44" />

## 🚀 About the Project
This case study explores customer subscriptions, churn, and revenue for a fictional online streaming service Foodie-Fi.
It focuses on SQL joins, aggregations, customer journey analysis, churn metrics, and payment behavior.

Inspired by Danny Ma’s #8WeekSQLChallenge.

---
## 📂 Database and Tables
**Database:** foodie_fi

**Tables:**
- plans – Subscription plans offered (`plan_id`,`plan_name`, `price`)
- subscriptions – Customer subscriptions over time (`customer_id`, `plan_id`, `start_date`)

  ---
  ## Entity Relationship Diagram
  <img width="500" height="520" alt="Image" src="https://github.com/user-attachments/assets/5fd3ab75-25a2-4bbc-89a9-939224fdccbf" />

  ---
  ## 🛠️ Setup Instructions
1. **Create the database and select it:**
    ```sql
    CREATE DATABASE IF NOT EXISTS Foodie_Fi;
      USE Foodie_Fi;
    ```
2. **Create the tables:**
    - `plans`
    - `subscriptions`
3. **Insert the provided sample data** into each table.

4. **Run the SQL queries** to solve business questions.

---
## ❓ Business Questions Solved
 ### A. 👥 Customer Analytics

- 🔢 Total number of customers.
- 📅 Monthly distribution of trial plan sign-ups.
- 🆕 Plan subscriptions starting after 2020 by plan type.
- 🚪 Customers who churned (count & %).
- ⚡ Customers who churned immediately after their free trial.
- 🔄 Plan transitions after trial (counts & percentages).
- 📊 Breakdown of active customers by plan at 2020-12-31.

### B. 📈 Subscription Journey

- 📅 Customers upgrading to annual plan in 2020.
- ⏳ Average time (days) to upgrade from trial to annual plan.
- 🗓️ Breakdown of upgrade durations into 30-day periods.
- ⬇️ Customers who downgraded from pro monthly → basic monthly in 2020.

### C. 💵 Payment Analysis

- 🗂️ Create a payments_2020 table with customer, plan, price, and start_date.
- 💰 Analyze customer payments in 2020 by subscription type.

  ---

## 🧠 Skills Practiced
- SQL Joins
- Aggregations & Group By
- CASE Statements
- Window Functions
- Time and Date Functions
- Data Cleaning
- Analytical Thinking

