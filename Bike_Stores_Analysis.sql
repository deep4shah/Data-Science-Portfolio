-- Brand wise sales
select p.brand_id, b.brand_name, cast(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount)))as INTEGER) AS total_sales
FROM order_items oi
join products p on oi.product_id = p.product_id
join brands b on p.brand_id = b.brand_id
group by p.brand_id
order by total_sales DESC;

--category wise sales
select c.category_id, c.category_name, cast(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount)))as INTEGER) AS total_sales
FROM order_items oi
join products p on oi.product_id = p.product_id
join categories c on p.category_id = c.category_id
group by c.category_id
order by total_sales DESC;

--Exploring brands, categories & products
select b.brand_id, b.brand_name, c.category_name, p.product_name, p.model_year, p.list_price
FROM products p
join brands b
on p.brand_id = b.brand_id
join categories c
on p.category_id = c.category_id
group by p.product_name
order by b.brand_name;

----Brand wise, category wise sales
select b.brand_name, c.category_name, CAST(round(sum(oi.list_price*oi.quantity),0) as INTEGER) as total_sales
from order_items oi
join products p
on oi.product_id = p.product_id
join brands b
on p.brand_id = b.brand_id
join categories c
on p.category_id = c.category_id
group by b. brand_name, category_name
order by brand_name,total_sales DESC;

--Year on year sales
select 
	strftime('%Y', o.order_date) AS year,
	cast(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount)))as INTEGER) AS total_sales
from order_items oi
Join orders o
on oi.order_id = o.order_id
group by strftime('%Y', o.order_date)
order by year;

-- Top 10 selling products based on quantity, ranked
select p.product_id, p.product_name, b.brand_name, sum(oi.quantity) as total_quantities_sold
from order_items oi
join products p
on oi.product_id = p.product_id
join brands b
on p.brand_id = b.brand_id
group by p.product_id
order by total_quantities_sold DESC
LIMIT 10;

--Top 10 products based on revenue, ranked
SELECT 
    p.product_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales_amount,
    SUM(oi.quantity) AS quantity_sold,
	cast (SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as INTEGER) As total_sales,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.list_price * (1 - oi.discount)) DESC) AS total_sales_rank
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales_rank
LIMIT 10;


--product wise sales vs stocks
SELECT 
    p.product_id, 
    p.product_name,
    COALESCE(sales.qty_sold, 0) AS qty_sold,
    COALESCE(stocks_1.available_stocks, 0) AS available_stocks
FROM 
    products p
LEFT JOIN (
    SELECT product_id, SUM(quantity) AS qty_sold
    FROM order_items
    GROUP BY product_id
) sales ON p.product_id = sales.product_id
LEFT JOIN (
    SELECT product_id, SUM(quantity) AS available_stocks
    FROM stocks
    GROUP BY product_id
) stocks_1 ON p.product_id = stocks_1.product_id
ORDER BY qty_sold DESC;


--city wise customers' count
select state, city, count(distinct customer_id) as Customer_count
from customers
group by city, state
order by Customer_count Desc ;

--Top 10 customers
select c.customer_id, c.first_name, c.last_name, c.phone, c.email, c.city, c.state, count(distinct(o.order_id)) As no_of_orders,
CAST(sum(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))) As INTEGER) AS total_spent
FROM customers c
join orders o ON c.customer_id = o.customer_id
join order_items oi ON o.order_id = oi.order_id
group by c.customer_id
order by total_spent desc
limit 10;

--store wise sales
select o.store_id, s.store_name, s.city, s.state, cast(sum (quantity * (list_price - (list_price*discount)))as INTEGER) as total_sales
from order_items oi
join orders o
on oi.order_id = o.order_id
join stores s
on o.store_id = s.store_id
group by o.store_id
order by total_sales desc;

--Top 10 cities based on sales
select c.city, c.state, cast(sum(quantity * (list_price - (list_price*discount)))as INTEGER) as total_sales
from order_items oi
join orders o
on oi.order_id = o.order_id
join customers c
on o.customer_id = c.customer_id
group by c.city
order by total_sales desc
limit 10;


-- late orders
SELECT 
    *,
    CASE WHEN shipped_date > required_date THEN "yes"
         ELSE 0
         END AS 'shipped_late'
FROM 
    orders
LIMIT 20;


--List details(Email and Phoner Number) of all the staffs and customers.
select first_name, last_name, phone, email, "Customer" AS Person_Type
from customers
UNION
select first_name, last_name, phone, email, "Staff" AS Person_Type
from staffs
order by person_type Desc;

-- Customer Wise recent and second recent order(Self_join)
SELECT 
    t1.customer_id, c.first_name,
    MAX(t1.order_date) AS most_recent_order,
    MAX(t2.order_date) AS second_most_recent_order
FROM 
    orders t1
INNER JOIN
    orders t2
ON 
    t1.customer_id = t2.customer_id
AND
    t1.order_date > t2.order_date
JOIN customers c
on t1.customer_id = c.customer_id

GROUP BY
    t1.customer_id;


--staff performance rank wise
select 
rank() over (
	order by sum(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))) Desc) As Rnk,
s.staff_id, s.first_name, s.last_name, s.store_id, str_1.store_name, 
CAST(sum(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))) as INTEGER) As total_sales
from staffs s
left JOIN orders o on s.staff_id = o.staff_id
left JOIN order_items oi on o.order_id = oi.order_id
left JOIN stores str_1 on s.store_id = str_1.store_id
group by s.staff_id
order by rnk;

--Percentage of Repeat customers
select store_name, 
count (case when status = "repeat" then 1 end) as Repeat_cutomers,
count (case when status = "new" then 1 end) as New_customers,
Round (100* count (case when status = "repeat" then 1 end) / count(*),2) || "%" as Repeat_percentage
from (
	SELECT 
		cu.customer_id,
		s.store_name,
		CASE 
			WHEN COUNT(DISTINCT o.order_id) > 1 THEN "repeat"
			ELSE "new"
			END AS status
	FROM customers cu
	JOIN orders o ON o.customer_id = cu.customer_id
	JOIN stores s ON s.store_id = o.store_id
	GROUP BY 
      cu.customer_id, s.store_name
	  ) customer_status_by_store
group by store_name
order by COUNT(CASE WHEN status = "repeat" THEN 1 END) 
        / COUNT(*) DESC;	