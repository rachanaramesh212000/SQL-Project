use foodie_fi;
select* from plans;
select* from subscriptions;
# CUSTOMER_JOURNEY
# Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each 
# customer’s onboarding journey.
# Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!
select * from subscriptions s inner join plans p using (plan_id) where customer_id <=8 limit 100;
# DATA ANALYSIS QUESTIONS
# 1. How many customers has Foodie-Fi ever had.
select count(distinct(customer_id)) as customer_count from subscriptions;
# 2.What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
select year(start_date) as year, month(start_date) as month ,count(customer_id) as trial_members  from subscriptions where plan_id=0 group by month,year
order by year,month;
#3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
select p.plan_name,count(*) as trial_count  from subscriptions s  inner join plans p where year(s.start_date)> 
2020 group by p.plan_name order by trial_count desc;
# 4 What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
 select count(distinct case when p.plan_name = 'churn' then s.customer_id end) as churned_customers,
count(distinct s.customer_id) as total_customers,round(100.0 * count(distinct case when p.plan_name = 'churn'
 then s.customer_id end) / count(distinct s.customer_id),1) as churn_percentage
from subscriptions s inner join plans p using(plan_id);
# How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
select count(distinct s1.customer_id) as churned_after_trial,
    count(distinct s2.customer_id) as total_customers,
    round(
        100.0 * count(distinct s1.customer_id) / count(distinct s2.customer_id), 0
    ) as churn_percentage
from subscriptions s1
join subscriptions s2 on s1.customer_id = s2.customer_id
where s1.plan_id = 0 
  and s2.plan_id = 4 
  and s2.start_date > s1.start_date;
  
  # What is the number and percentage of customer plans after their initial free trial?
select 
    p.plan_name,
    count(distinct s2.customer_id) as customer_count,round(100.0 * count(distinct s2.customer_id) / 
    (select count(distinct customer_id) from subscriptions),1) as percentage_after_trial from subscriptions s1 join subscriptions s2 
on s1.customer_id = s2.customer_id 
join plans p 
on s2.plan_id = p.plan_id
where s1.plan_id = 0
and s2.start_date > s1.start_date 
group by p.plan_name
order by customer_count desc;

# What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
select p.plan_name,count(distinct s.customer_id) as customer_count,round(100.0 * count(distinct s.customer_id)/ 
(select count(distinct customer_id) from subscriptions),1) as percentage
from subscriptions s join plans p using(plan_id)     
where s.start_date <= '2020-12-31'and not exists (select 1 from subscriptions s2 where s2.customer_id = s.customer_id
and s2.start_date <= '2020-12-31'and s2.start_date > s.start_date) group by p.plan_name order by customer_count desc;

# How many customers have upgraded to an annual plan in 2020?
select count(distinct s.customer_id) as annual_upgrades_2020
from subscriptions s
join plans p on s.plan_id = p.plan_id
where p.plan_name = 'annual'
  and year(s.start_date) = 2020;

# How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
select round(avg(datediff(a.start_date, t.start_date)),1) as avg_days_to_annual from subscriptions t join subscriptions a 
on t.customer_id = a.customer_id where t.plan_id = 0 and a.plan_id = 3;

# Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

# How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
select count(distinct s1.customer_id) as downgraded_customers from subscriptions s1 join subscriptions s2 on s1.customer_id = s2.customer_id
 and s2.start_date > s1.start_date where s1.plan_id = 2 and s2.plan_id = 1 and year(s2.start_date) = 2020;

#  C. Challenge Payment Question

create table payments_2020 as
select s.customer_id, s.plan_id, p.plan_name, p.price, s.start_date
from subscriptions s
join plans p using(plan_id)
where year(s.start_date) = 2020;
select * from payments_2020;




