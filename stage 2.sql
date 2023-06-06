-- menampilkan tabel yang memiliki informasi total revenue untuk masing-masing tahun
with 
tmp as(
select 
	date_part('year', o.order_purchase_timestamp) as year,
	round(sum(revenue_per_order)::numeric,3) as revenue
from (
	select 
		order_id, 
		sum(price+freight_value) as revenue_per_order
	from order_items_dataset
	group by 1
) sq
join orders_dataset o on sq.order_id = o.order_id
where o.order_status = 'delivered'
group by 1
order by 1
),

-- menampilkan tabel yang memiliki informasi jumlah cancel order total untuk masing-masing tahun
tmp2 as (
select 
	date_part('year', order_purchase_timestamp) as year,
	count(1) as sum_cancel_order
from orders_dataset
where order_status = 'canceled'
group by 1
order by 1
),

-- menampilkan tabel yang memiliki informasi nama kategori yang memberikan pendapatan total tertinggi untuk masing-masing tahun
tmp3 as (
select
	order_year as year,
	top_product,
	top_revenue
from (
	select 
		date_part('year', o.order_purchase_timestamp) as order_year,
		p.product_category_name as top_product,
		round(sum(oi.price + oi.freight_value)::numeric,3) as top_revenue,
		row_number() over (
			partition by date_part('year', o.order_purchase_timestamp) 
			order by sum(oi.price + oi.freight_value) desc) as row_num
	from order_items_dataset as oi
	join orders_dataset as o on o.order_id = oi.order_id
	join product_dataset as p on p.product_id = oi.product_id
	where order_status = 'delivered'
	group by 1,2
) as sq
where row_num = 1
order by 1
),

-- menampilkan tabel yang memiliki informasi nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun
tmp4 as (
select
	order_year as year,
	cancel_product,
	top_sum_cancel
from (
	select 
		date_part('year', o.order_purchase_timestamp) as order_year,
		p.product_category_name as cancel_product,
		count(1) as top_sum_cancel,
		row_number() over (
			partition by date_part('year', o.order_purchase_timestamp) 
			order by count(1) desc) as row_num
	from order_items_dataset as oi
	join orders_dataset as o on o.order_id = oi.order_id
	join product_dataset as p on p.product_id = oi.product_id
	where order_status in ('canceled')
	group by 1,2
) as sq
where row_num = 1
order by 1
)

-- menggabungkan seluruh tabel diatas menjadi satu tabel aggregasi
select 
	tmp.year,
	tmp3.top_product,
	tmp3.top_revenue,
	tmp.revenue,
	tmp4.cancel_product,
	tmp4.top_sum_cancel,
	tmp2.sum_cancel_order	
from tmp
join tmp2
	on tmp.year = tmp2.year
left join tmp3
	on tmp.year = tmp3.year
left join tmp4
	on tmp.year = tmp4.year

	
