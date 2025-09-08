# 🏦 Data Bank - SQL Case Study
<img width="500" height="525" alt="Image" src="https://github.com/user-attachments/assets/17a851ef-d69f-4f24-adeb-b9ded1fe6ba9" />

## 🚀 About the Project
This case study is designed to strengthen SQL and data analysis skills by solving real-world style business questions for a fictional digital bank, Data Bank.
It focuses on SQL querying, customer behavior analysis, transactions, data allocation strategies, and performance metrics.

Inspired by Danny Ma’s #8WeekSQLChallenge.

## 📂 Database and Tables
**Database:** data_bank

**Tables:**

- regions – Details of Data Bank regions (region_id, region_name)
- customer_nodes – Node allocations for each customer (customer_id, region_id, node_id, start_date, end_date)
- customer_transactions – Transaction details (customer_id, txn_date, txn_type, txn_amount)

# Entity Relationship Diagram
  <img width="796" height="342" alt="Image" src="https://github.com/user-attachments/assets/9a714c8e-1f70-436b-bfca-21a1ddecc437" />

  ## 🛠️ Setup Instructions
  1. **Create the database and select it:**
  
  ````sql
CREATE DATABASE IF NOT EXISTS data_bank;
USE data_bank;
````
2. **Create the tables:**
   - `regions`
   - `customer_nodes`
   - `customer_transactions`
3. **Insert the provided sample data** into each table.
4. **Run the SQL queries** to solve business questions. 

---
## ❓ Business Questions Solved
### A. 📍 Customer Nodes Exploration

- 🔢 Unique nodes in the Data Bank system.
- 🌍 Number of nodes per region.
- 👥 Customers allocated to each region.
- 📆 Average days customers stay on a node before reallocation.
- 📊 Median, 80th, and 95th percentile of reallocation days per region.

### B. 💰 Customer Transactions

- 🔄 Unique customer count & total transaction amount by type.
- 💵 Average total historical deposit counts & amounts per customer.
- 📅 Monthly customers making >1 deposit and (≥1 purchase OR ≥1 withdrawal).
- 🏦 Closing balance for each customer at the end of each month.

### C. 📡 Data Allocation Challenge

- 📊 Option 1: Allocation based on previous month’s closing balance.
- 📊 Option 2: Allocation based on 30-day average balance.
- 📊 Option 3: Allocation updated in real-time.
- 🔄 Running balance impact of each transaction.
- 📆 End-of-month balances per customer.
- 📉 Minimum, average, and maximum running balance for each customer.

### D. 📈 Extra Challenge – Interest Growth

- 🏦 Daily interest calculation at 6% annual rate (non-compounding).
- ➕ Extension: Daily compounding interest option.

  ---
  ## 🧠 Skills Practiced
- SQL Joins
- Aggregations
- Window Functions
- Date & Time Functions
- Percentiles (NTILE)
- Running Totals
- Financial Calculations
- Analytical Thinking

  ---
