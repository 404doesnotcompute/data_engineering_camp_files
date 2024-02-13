-- external table creation 
CREATE OR REPLACE EXTERNAL TABLE dtc-de-course-411501.green_taxi_data_2022.green_taxi
  OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-jorgerubio/2022_green_taxi_data.parquet']);


-- creation of BQ table with no partition or clustering
CREATE OR REPLACE TABLE dtc-de-course-411501.green_taxi_data_2022.green_taxi_non_partitioned AS
SELECT * FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi;

-- checking data just created on statement above 
SELECT * FROM green_taxi_data_2022.green_taxi LIMIT 10;

-- 0 MB estimated when ran
SELECT COUNT(DISTINCT pulocationid) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi;

-- 6.41MB estimated when ran
SELECT COUNT(DISTINCT pulocationid) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi_non_partitioned;

--count of records that have a fare amount of 0 = 1622
SELECT COUNT(*) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi_non_partitioned
WHERE fare_amount = 0;

-- partitioned  0MB partition from external table
CREATE OR REPLACE TABLE dtc-de-course-411501.green_taxi_data_2022.green_taxi_partitioned
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY pulocationid AS
SELECT * FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi;

-- 12.82MB when ran from non partitione table 
SELECT DISTINCT(pulocationid) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi_non_partitioned
WHERE lpep_pickup_date BETWEEN '2020-06-02' and '2022-06-30'


-- 12.82MB for partitioned tables
SELECT DISTINCT(pulocationid) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi_partitioned
WHERE lpep_pickup_date BETWEEN '2020-06-02' and '2022-06-30';

--looking into the partitions
SELECT table_name, partition_id, total_rows
FROM `green_taxi_data_2022.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'green_taxi_partitioned'
ORDER BY total_rows DESC;

