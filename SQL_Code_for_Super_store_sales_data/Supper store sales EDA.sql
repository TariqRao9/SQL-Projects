# EDA by using sql on super store sales data

select*
from super_store.store_data
;

select count(*) as Total_count
from store_data
;

select sum(quantity) as Total_product_quantity,
round(sum(profit),2) as Total_profit,
round(sum(shipping_cost),2) as Total_shipping_cost
from super_store.store_data
;

select round(sum(discount * sales),2) as Total_discount_given
from super_store.store_data
;


select segment,
sum(sales) as sales_by_segment
from store_data
group by segment
;

select customer_name, 
sum(sales) as sales_by_customer
from super_store.store_data
group by customer_name
order by 2 desc
;

with Top_5_customers as
(
select customer_name, 
sum(sales) as sales_by_customer,
dense_rank() over(order by sum(sales) desc) as Ranking
from super_store.store_data
group by customer_name
order by 2 desc
)
select *
from Top_5_customers
where ranking <= 5
;

select sub_category,
sum(sales) as sales_by_subcategory
from super_store.store_data 
group by sub_category
order by 2 desc
;

select country,
sum(sales) as country_by_sales
from super_store.store_data
group by country
order by 2 desc
;

select country,
sum(sales) as country_by_sales
from super_store.store_data
where country ='pakistan'
group by country
order by 2 desc
;

select year,
sum(sales) as sales_by_year
from store_data
group by year
;

with top_3_companies_by_sales_in_years as
(
select country,year,
sum(sales) as sales_by_year,
dense_rank() over(partition by year order by sum(sales) desc) as Ranking
from super_store.store_data
group by country,year
)
select*
from top_3_companies_by_sales_in_years
where ranking <=3
;

select*
from store_data
