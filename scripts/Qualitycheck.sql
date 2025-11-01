https://github.com/SaiKamal07/sql-datawarehouse-project1use datawarehouse1;

select cst_id from silver.crm_cust_info
where cst_id is null ; -- to check null values



select cst_id ,
count(*)
from silver.crm_cust_info
group by cst_id 
having count(*)> 1; -- t0 check null values

select cst_id ,
count(*)
from silver.crm_cust_info
group by cst_id 
having count(*) >1 or cst_id is null; -- to check whether null values and diuplicate values  are  exists

select cst_firstname from silver.crm_cust_info
where cst_firstname != trim(cst_firstname);  -- had extra spaces data - unwanted data for firstname

select cst_lastname from silver.crm_cust_info
where cst_lastname != trim(cst_lastname);    -- for lastname

select cst_gndr from silver.crm_cust_info
where cst_gndr != trim(cst_gndr); 

select cst_marital_status from silver.crm_cust_info
where cst_marital_status != trim(cst_marital_status); 


select * from bronze.crm_prd_info

select * from bronze.erp_px_cat_g1v2


select * from bronze.crm_sales_details

select * from silver.crm_prd_info


--crm_prd_info

select prd_id ,
count(*)
from silver.crm_prd_info
group by prd_id 
having count(*) >1 or prd_id is null; -- to check whether null values and diuplicate values  are  exists

select * from bronze.crm_sales_details

select * from bronze.erp_px_cat_g1v2


select prd_nm from silver.crm_prd_info
where prd_nm != trim(prd_nm); --- to check any unwanted things in prd_nm

select prd_cost from bronze.crm_prd_info
where prd_cost is null or prd_cost <= 0;   -- to check any null values in product-cost



select * from bronze.crm_prd_info
 where prd_end_dt < prd_start_dt


 -- fix _sales_details

 select * from bronze.crm_sales_details

 select sls_ord_num from bronze.crm_sales_details
 where sls_ord_num != trim(sls_ord_num)

  select sls_ord_num from bronze.crm_sales_details
where sls_prd_key not in (select prd_key from silver.crm_prd_info)

select sls_order_dt from bronze.crm_sales_details
where sls_order_dt !=len(sls_order_dt) ;

select sls_order_dt from bronze.crm_sales_details
where len(sls_order_dt) <=0;

select sls_order_dt from bronze.crm_sales_details
where sls_order_dt is null ;

select sls_ship_dt from bronze.crm_sales_details
where sls_ship_dt !=len(sls_ship_dt) or sls_ship_dt is null;



select sls_due_dt from bronze.crm_sales_details
where sls_due_dt !=len(sls_due_dt);


-- _erp_cust_az12

select * from bronze.erp_cust_az12

select * from bronze.crm_cust_info

select distinct bdate from  bronze.erp_cust_az12
where bdate > getdate() or bdate < '1925-10-17';

select distinct gen from  bronze.erp_cust_az12;



-- _erp_loc_a101

select * from bronze.erp_loc_a101;

select * from bronze.crm_cust_info;

select distinct cntry from bronze.erp_loc_a101;

select *  from silver.erp_loc_a101;


--_ erp.px_cat_g1v2

select * from bronze.erp_px_cat_g1v2;


select * from silver.crm_prd_info;

select distinct cat from bronze.erp_px_cat_g1v2;

select distinct subcat from bronze.erp_px_cat_g1v2;

select distinct maintenance from bronze.erp_px_cat_g1v2;
