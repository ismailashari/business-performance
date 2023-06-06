-- menampilkan tabel yang memiliki informasi rata-rata monthly active user untuk setiap tahun
with
tmp as (
	select 
		order_year,
		round(avg(jumlah_customer),2) as avg_monthly_active_user
	from (
		select
			date_part('year', o.order_purchase_timestamp) as order_year,
			date_part('month', o.order_purchase_timestamp) as order_month,
			count(distinct c.customer_unique_id) as jumlah_customer
		from orders_dataset as o
		join customers_dataset as c
			on o.customer_id = c.customer_id
		group by 1,2
	) as sq
	group by 1
	order by 1
),

-- menampilkan tabel yang berisi informasi jumlah customer baru (pertama kali bertransaksi) pada masing-masing tahun
tmp2 as (
	select
		date_part('year', transaksi_pertama) as order_year,
		count(1) as customer_baru
	from (
		select
			c.customer_unique_id,
			min(o.order_purchase_timestamp) as transaksi_pertama
		from orders_dataset as o
		join customers_dataset as c
			on o.customer_id = c.customer_id
		group by 1
	) as sq
	group by 1
	order by 1
),

-- menampilkan tabel yang memiliki informasi repeat order pada masing-masing tahun
tmp3 as (
	select
		order_year, 
		count(distinct customer_unique_id) as jumlah_pelanggan_repeat_order
	from
	  (
		select 
			date_part('year', order_purchase_timestamp) as order_year,
			c.customer_unique_id,
			count(1) as jumlah_order
		from orders_dataset as o
		join customers_dataset as c
		  on c.customer_id = o.customer_id
		group by 1,2
		having count(1) > 1
	  ) as sq
	group by 1
	order by 1
),

-- menampilkan tabel yang memiliki informasi rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun
tmp4 as (
	select
		order_year,
		round(avg(jumlah_order),3) as avg_freq_order
	from
	  (
		select
		  date_part('year', order_purchase_timestamp) as order_year,
		  c.customer_unique_id,
		  count(1) as jumlah_order
		from orders_dataset as o
		join customers_dataset as c
		  on c.customer_id = o.customer_id
		where order_status in ('delivered', 'shipped', 'invoiced', 'processing')
		group by 1,2
	  ) as sq
	group by 1
	order by 1
)


select 
	tmp.order_year as year,
	tmp.avg_monthly_active_user as mau,
	tmp2.customer_baru as new_customer,
	tmp3.jumlah_pelanggan_repeat_order as repeat_customers,
	tmp4.avg_freq_order as avg_order_per_cust
from tmp
join tmp2
	on tmp.order_year = tmp2.order_year
join tmp3
	on tmp.order_year = tmp3.order_year
join tmp4
	on tmp.order_year = tmp4.order_year