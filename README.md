# Analyzing eCommerce Business Performance with SQL

## Introduction
In this project we need to analyze ecommerce business performance for each year in 2016-2018 by looking to annual customer activity growth, annual product category quality and annual payment type usage. For analyze it I used SQL with PostgreSQL tools.

## Stage 1 - Annual Customer Activity Growth
In this stage we analyze annual customer activity growth per years by looking to these objectives:
- Monthly Active User
- New Customer
- Customer Repeat Order
- Average Order per Customer

## Stage 2 - Annual Product Category Quality
In this stage we analyze annual product category quality per years by looking to these objectives:
- Total Revenue each Year
- Total Cancel Order each Year
- Top Product Category by Revenue
- Most Canceled Product Category

## Stage 3 - Annual Payment Type Usage
In this stage we analyze annual payment type usage per years by looking to these objectives:
- All Time Total Payment Type Used
- Payment Type Used each Year

## Summary and Conclusion

### Annual Customer Activity Growth

![alt_text](/img/avg_mau.jpg)

The available data starts from the transactions in September 2016, which leads to a significant difference in the analysis results between 2016 and the subsequent years of 2017 and 2018. From this analysis, it is evident that the monthly active user (MAU) activity and the number of new customers have increased.

![alt_text](/img/repeat%20cust.jpg)

On the other hand, in terms of customer orders, it appears to be not good. It can be observed that the majority of customers only place an order once throughout the year. In fact, the number of customers who make repeat orders has slightly decreased from 2017 to 2018.

### Annual Product Category Quality

![alt_text](/img/top%20product%20-%20most%20cancel.jpg)

From this analysis, it is evident that the product categories generating the highest revenue each year undergo changes. Additionally, when considering the overall revenue of the company, there is an increase every year.
The category of products experiencing the highest number of cancellations also changes every year. An interesting point to note here is that the health & beauty category is both the top revenue-generating category and the category with the most cancellations in 2018. This might be attributed to the fact that the health & beauty category dominated the overall transactions during that year. Further analysis can be conducted to validate this observation.

### Annual Payment Type Usage

![alt_text](/img/payment%20type.jpg)

Overall, the preferred payment method is credit card, indicating the need for further analysis on customer habits when using credit cards. This analysis can include factors such as the preferred tenor duration, product categories commonly purchased with credit cards, and more. Another interesting point to note is the significant increase in debit card usage, surpassing 100% from 2017 to 2018. Conversely, the usage of vouchers has decreased during the same period. This might be attributed to specific promotions or collaborations with certain debit cards, as well as a reduction in voucher-based promotional methods. Further analysis can be conducted by consulting other departments such as Marketing or Business Development to validate these observations.
