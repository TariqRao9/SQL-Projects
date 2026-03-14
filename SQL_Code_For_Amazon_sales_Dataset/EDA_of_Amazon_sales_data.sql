
## EDA on Amazon sales dataset

select*
from amazon_sales_data
;

select count(*) As Total_rows_count
from amazon_sales_data
;

select distinct product_category, round(sum(profit),2) as Total_Profit
from amazon_sales_data
group by product_category
order by 2 desc
;

select round(avg(price),2) as Avg_price,
round(avg(total_revenue),2) as Avg_total_revenue,
round(avg(profit),2) as Avg_Profit
from amazon_sales_data
;

select round(avg(rating),2) as Avg_Rating
from amazon_sales_data
;


select sum(quantity_sold) as Quantity_sold,
round(sum(total_revenue),2) as Revenue,
round(sum(profit),2) as Profit
from amazon_sales_data
;


select year(`order_date`) as Years,round(sum(total_revenue),2) as Total_revenue
from amazon_sales_data
group by year(`order_date`)
;

select payment_method, count(payment_method) as Total_count
from amazon_sales_data
group by payment_method
;
select customer_region, round(sum(total_revenue),2) as Total_revenue,
dense_rank() over(order by sum(total_revenue) desc) as Ranking
from amazon_sales_data
group by customer_region
;


with Top_3_categories as
(
select product_category, year(`order_date`),round(sum(total_revenue),2),
dense_rank() over( partition by year(`order_date`) order by sum(total_revenue) desc ) as ranking
from amazon_sales_data
group by product_category,year(`order_date`)
)
select *
from Top_3_categories
where ranking <=3
;
