/* 4/ 2024
AdventureWorks Sales Analysis Project: Utilizing BigQuery for Business Insights
Description: Leveraged BigQuery to analyze sales data from the AdventureWorks sample database. Performed tasks including querying data for sales trends, customer behavior analysis and product performance evaluation.
https://console.cloud.google.com/bigquery?sq=204658862253:da61f7544db34c6d8d5382e14ff7e1a3
*/

-- Query 1:Calc Quantity of items, Sales value & Order quantity by each Subcategory in L12M
select 
  FORMAT_DATE('%b %Y', a.ModifiedDate) period
  , c.Name
  , sum(a.OrderQty) qty_item
  , sum(a.LineTotal) total_sales
  , count(distinct a.SalesOrderID) order_cnt
from `adventureworks2019.Sales.SalesOrderDetail` a
left join `adventureworks2019.Production.Product` b
  using(ProductID)
left join `adventureworks2019.Production.ProductSubcategory` c
  on cast(b.ProductSubcategoryID as int) = c.ProductSubcategoryID
group by 1, 2;

-- Query 2: Calc % YoY growth rate by SubCategory & release top 3 cat with highest grow rate. Can use metric: quantity_item. Round results to 2 decimal
with cte as (
  select 
    FORMAT_DATE('%Y', a.ModifiedDate) period
    , c.Name
    , sum(a.OrderQty) qty_item
  from `adventureworks2019.Sales.SalesOrderDetail` a
  left join `adventureworks2019.Production.Product` b
    using(ProductID)
  left join `adventureworks2019.Production.ProductSubcategory` c
    on cast(b.ProductSubcategoryID as int) = c.ProductSubcategoryID
  group by 1, 2)
select 
  name
  , qty_item
  , qty_prv
  , (qty_item/qty_prv)-1 rate
from (
  select 
    *, lead(qty_item) over(partition by name order by name, period desc) qty_prv
  from cte
  order by name, period)
order by rate desc
limit 3;

-- Query 3: Ranking Top 3 TeritoryID with biggest Order quantity of every year. If there's TerritoryID with same quantity in a year, do not skip the rank number
with cte as(
  select 
    FORMAT_DATE('%Y', a.ModifiedDate) yr
    , b.TerritoryID
    , sum(a.OrderQty) order_cnt
  from `adventureworks2019.Sales.SalesOrderDetail` a
  left join `adventureworks2019.Sales.SalesOrderHeader` b
  on a.SalesOrderID = b.SalesOrderID
  group by 1, 2)

select *
from 
  (select *, dense_rank() over(partition by yr order by order_cnt desc) rk
  from cte) sub
where rk in(1,2,3);

-- Query 4: Calc Total Discount Cost belongs to Seasonal Discount for each SubCategory
with cte as (
  select 
    FORMAT_DATE('%Y', a.ModifiedDate) yr
    , c.Name
    , DiscountPct
    , UnitPrice
    , sum(a.OrderQty) qty_item
  from `adventureworks2019.Sales.SalesOrderDetail` a
  left join `adventureworks2019.Sales.SpecialOffer` d
    using(SpecialOfferID)
  left join `adventureworks2019.Production.Product` b
    using(ProductID)
  left join `adventureworks2019.Production.ProductSubcategory` c
    on cast(b.ProductSubcategoryID as int) = c.ProductSubcategoryID
  where lower(d.type) like '%seasonal discount%'
  group by 1, 2, 3, 4)

select yr, name, DiscountPct * UnitPrice * qty_item total_cost
from cte;

-- Query 5:Retention rate of Customer in 2014 with status of Successfully Shipped (Cohort Analysis)
with cte as ( 
  --bảng khách hàng -  thgian mua hàng
  select 
    CustomerID
    , extract(month from ModifiedDate) month_join
  from `adventureworks2019.Sales.SalesOrderHeader`
  where status = 5
    and cast(FORMAT_DATE('%Y', ModifiedDate) as string) ='2014'
  )

, new_ctm as (
  -- bảng new ctm theo tháng
  select 
    CustomerID
    , min(month_join) first_month
  from cte
  group by 1
  )

, num_new_ctm as (
  -- đếm slg khách hàng mới theo tháng
  select 
    first_month
    , count(distinct CustomerID) num_new_ctm
  from new_ctm
  group by 1
  )

, cte1 as (
  select *
  from new_ctm
  left join cte
  using(CustomerID)
  --on cte.CustomerID = new_ctm.CustomerID
  order by cte.CustomerID, month_join
  )

, num_retained_ctm as (
  -- đếm số KH quay lại theo từng tháng
  select 
    first_month
    , month_join retention_month
    , count(distinct CustomerID) num_retained_ctm
  from cte1
  group by 1, 2
  order by 1, 2
  )

select 
  b.first_month
  , b.num_new_ctm
  , a.retention_month
  , a.num_retained_ctm
  , (100 * a.num_retained_ctm /  b.num_new_ctm) rate
from num_new_ctm b
left join num_retained_ctm a
using(first_month)
order by 1, 3;

-- Query 6: Trend of Stock level & MoM diff % by all product in 2011. If %gr rate is null then 0. Round to 1 decimal
with cte as(
  select 
    ProductID
    , extract(month from ModifiedDate) mth
    , extract(year from ModifiedDate) yr
    , sum(StockedQty) stock_qty
  from `adventureworks2019.Production.WorkOrder`
  where cast(FORMAT_DATE('%Y', ModifiedDate) as string) ='2011'
  group by 1, 2, 3
  )
, cte1 as (
  select 
    a.Name
    , cte.mth
    , cte.yr
    , cte.stock_qty
    , lead(cte.stock_qty) over(partition by a.ProductID order by cte.yr, cte.mth desc) stock_prv
  from cte
  left join `adventureworks2019.Production.Product` a
  on cte.ProductID = a.ProductID
  order by 1, 3, 2 desc
  )
select *
  , case when round(100 * (stock_qty - stock_prv)/stock_prv, 1) is null then 0
      else round(100 * (stock_qty - stock_prv)/stock_prv, 1) end as rate
from cte1;

-- Query 7: "Calc Ratio of Stock / Sales in 2011 by product name, by month
with order_qty as (
  select 
    b.ProductID
    , b.Name
    , extract(month from a.ModifiedDate) mth
    , extract(year from a.ModifiedDate) yr
    , sum(a.OrderQty) order_qty
  from `adventureworks2019.Sales.SalesOrderDetail` a
  left join `adventureworks2019.Production.Product` b
  on a.ProductID = b.ProductID
  where extract(year from a.ModifiedDate) = 2011
  group by 1, 2, 3, 4
  )
, stock_qty as (
  select 
    ProductID
    , extract(month from ModifiedDate) mth
    , extract(year from ModifiedDate) yr
    , sum(StockedQty) stock_qty
  from `adventureworks2019.Production.WorkOrder`
  group by 1, 2, 3
  )
select 
  a.*
  , b.stock_qty
  , round(b.stock_qty / a.order_qty, 1) rate
from order_qty a
left join stock_qty b
on a.ProductID = b.ProductID
  and a.mth = b.mth
  and a.yr = b.yr
order by a.mth desc, rate desc;

-- Query 8: No of order and value at Pending status in 2014
select 
  extract(year from ModifiedDate) yr
  , status
  , count(distinct PurchaseOrderID ) order_qty
  , sum(TotalDue)
from `adventureworks2019.Purchasing.PurchaseOrderHeader`
where extract(year from ModifiedDate) = 2014
  and status = 1
group by 1, 2;