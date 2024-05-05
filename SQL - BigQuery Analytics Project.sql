/* 4/2024
BigQuery Analytics Project: Analyzing User Behavior in E-commerce Website
Google Analytics Sample Dataset
https://console.cloud.google.com/bigquery?sq=204658862253:cdde78bb3ffa4084a2aa3e7bcb2d3880
*/

-- Query 01: Calculate total visit, pageview, transaction for Jan, Feb and March 2017 (order by month)
SELECT  
  format_date("%Y%m", parse_date("%Y%m%d", date)) as month
  , SUM(totals.visits) AS visits
  , SUM(totals.pageviews) AS pageviews
  , SUM(totals.transactions) AS transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*` 
where _table_suffix between '0101' and '0331'
group by 1
order by 1;

-- Query 02: Bounce rate per traffic source in July 2017 (Bounce_rate = num_bounce/total_visit) (order by total_visit DESC)
SELECT
    trafficSource.source as source,
    sum(totals.visits) as total_visits,
    sum(totals.Bounces) as total_no_of_bounces,
    (sum(totals.Bounces)/sum(totals.visits))* 100 as bounce_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
GROUP BY source
ORDER BY total_visits DESC;

-- Query 3: Revenue by traffic source by week, by month in June 2017
SELECT 
  'Month' time_type
  ,format_date("%Y%m", parse_date("%Y%m%d", date)) as month
  , trafficSource.source AS source
  , sum(product.productRevenue)/1000000 revenue
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
unnest (hits) hits,
unnest (hits.product) product
group by 1, 2, 3

union all

select 
'Week' time_type
, format_timestamp('%Y%W', PARSE_DATE('%Y%m%d', date)) time
, trafficSource.source AS source
, sum(product.productRevenue)/1000000 revenue
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
unnest (hits) hits,
unnest (hits.product) product
group by 1, 2, 3

order by revenue desc;

-- Query 04: Average number of pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017.
with purchaser as (
  SELECT 
    --substr(date,0,6) month
    format_date("%Y%m", parse_date("%Y%m%d", date)) as month
    , sum(totals.pageviews)/count(distinct fullVisitorId) avg_pageviews_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*` ,
  unnest (hits) hits,
  unnest (product) product
  where _table_suffix between '0601' and '0731'
    and totals.transactions >= 1
    and product.productRevenue is not null
  group by 1)

, non_pur as (
  SELECT 
    --substr(date,0,6) month
    format_date("%Y%m", parse_date("%Y%m%d", date)) as month
    , sum(totals.pageviews)/count(distinct fullVisitorId) avg_pageviews_non_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
  unnest (hits) hits,
  unnest (product) product  
  where _table_suffix between '0601' and '0731'
    and totals.transactions is null
    and product.productRevenue is null
  group by 1)

select *
from purchaser
full join non_pur
using(month);

-- Query 05: Average number of transactions per user that made a purchase in July 2017
SELECT 
  --substr(date,0,6) month
  format_date("%Y%m", parse_date("%Y%m%d", date)) as month
  , sum(totals.transactions)/count(distinct fullVisitorId) Avg_total_transactions_per_user
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
unnest (hits) hits,
unnest (product) product 
where product.productRevenue is not null
group by 1;

-- Query 06: Average amount of money spent per session. Only include purchaser data in July 2017
SELECT 
  --substr(date,0,6) month
  format_date("%Y%m", parse_date("%Y%m%d", date)) as month
  , sum(product.productRevenue) / count(fullVisitorId) / 1000000 avg_revenue_by_user_per_visit
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
unnest (hits) hits,
unnest (product) product 
where totals.transactions is not null
  and product.productRevenue is not null
group by 1;

-- Query 07: Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017. Output should show product name and the quantity was ordered.
select 
  product.v2ProductName other_purchased_products
  , sum(product.productQuantity) quantity
from `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
unnest (hits) hits,
unnest (product) product
where fullVisitorId in(
    SELECT distinct fullVisitorId
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
    unnest (hits) hits,
    unnest (product) product
    where product.v2ProductName = "YouTube Men's Vintage Henley"
      and totals.transactions >=1
      and product.productRevenue is not null  --bổ sung đk này
      )
  and product.productRevenue is not null
  and product.v2ProductName <> "YouTube Men's Vintage Henley"
group by 1
order by 1;

-- Query 08: Calculate cohort map from product view to addtocart to purchase in Jan, Feb and March 2017. 

with cte as (
  SELECT 
    substr(date,0,6) month
    , case when eCommerceAction.action_type = '2' then 1 end as product_view
    , case when eCommerceAction.action_type = '3' then 1 end as addtocart
    , case when eCommerceAction.action_type = '6' and product.productRevenue is not null then 1 end as purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
  unnest (hits) hits,
  unnest (hits.product) product
  where _table_suffix between '0101' and '0331')

select 
  month
  , sum(product_view) num_product_view
  , sum(addtocart) num_addtocart
  , sum(purchase) num_purchase
  , 100 * sum(addtocart) / sum(product_view) add_to_cart_rate
  , 100 * sum(purchase) / sum(product_view) purchase_rate
from cte
group by 1
order by 1;
