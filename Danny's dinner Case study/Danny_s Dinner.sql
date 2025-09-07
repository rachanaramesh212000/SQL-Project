create database if not exists Dannys_dinner;
use Dannys_dinner;

#1. What is the total amount each customer spent at the restaurant?							
select customer_id,sum(price) as total_spent from sales as s inner join menu m using(product_id) group by customer_id;

#2. How many days has each customer visited the restaurant?	
select customer_id,count(distinct(order_date)) as no_of_visit from sales s group by customer_id;				

#2.1 How many times each customer visited the restaurant?	
select customer_id,count(customer_id) as no_of_visit from sales s group by customer_id;

#3. What was the first item from the menu purchased by each customer?	
select customer_id,product_name from (
select *,row_number() over(partition by customer_id) as rn from sales s inner join menu m using(product_id)) as t where rn=1;

#4. What is the most purchased item on the menu and how many times was it purchased by all customers?
select product_name,count(product_name) as no_of_times_purchased from sales inner join menu m using(product_id) group by product_name order by count(product_name) desc limit 1;

	# 5. Which item was the most popular for each customer?	
   select * from (
   select customer_id,product_name,count(*) as popular_item,dense_rank() over(partition by customer_id order by count(*) desc)as drnk from sales s inner join menu m using(product_id) group by customer_id,product_name) as t where drnk=1;
		
#6. Which item was purchased first by the customer after they became a member?						
#joins>condition where order date greater than joining date> 1st order

select * from (
select s.customer_id,order_date,join_date,product_name,row_number() over(partition by s.customer_id order by order_date asc) as rn from sales s inner join menu m using(product_id) inner join members as mb on s.customer_id=mb.customer_id 
and order_date>join_date) as t where rn=1;

#7. Which item was purchased just before the customer became a member?
			select * from (
select s.customer_id,order_date,join_date,product_name,rank() over(partition by s.customer_id order by order_date desc) as rn from sales s inner join menu m using(product_id) inner join members as mb on s.customer_id=mb.customer_id 
and s.order_date<join_date) as t where rn=1;			

#8. What is the total items and amount spent for each member before they became a member?							
select s.customer_id,count(s.customer_id) as no_of_items,sum(price) as total_amount_spent from sales s inner join menu m using(product_id) inner join members mb on s.customer_id=mb.customer_id order by customer_id;

#9 If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?							
select customer_id,sum(case when product_name= "sushi" then price*20 else price*10 end ) as total_points  from sales s inner join menu m using(product_id) group by customer_id;