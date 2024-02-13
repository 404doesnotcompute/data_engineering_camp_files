
#### Question 1 Answer: 
* 840,402 rows x 20 columns

#### Question 2 Answer: 
* 0 MB for the External Table and 6.41MB for the Materialized Table

```
-- 0 MB for external table estimated when ran 
SELECT COUNT(DISTINCT pulocationid) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi;

-- 6.41MB for materialized table estimated when ran
SELECT COUNT(DISTINCT pulocationid) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi_non_partitioned;

```
#### Question 3 Answer: 
* 1,622

```
-- count of records that have a fare amount of 0 = 1622
SELECT COUNT(*) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi_non_partitioned
WHERE fare_amount = 0;
```
#### Question 4 Answer: 
* Partition by lpep_pickup_datetime Cluster on PUlocationID

```
CREATE OR REPLACE TABLE dtc-de-course-411501.green_taxi_data_2022.green_taxi_partitioned
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY pulocationid AS
SELECT * FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi;
```

#### Question 5 Answer: 
* 10.31 MB for non-partitioned table and 10.31 MB for the partitioned table

```
-- 12.82MB when ran from non partitione table 
SELECT DISTINCT(pulocationid) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi_non_partitioned
WHERE lpep_pickup_date BETWEEN '2020-06-02' and '2022-06-30'


-- 12.82MB for partitioned tables
SELECT DISTINCT(pulocationid) FROM dtc-de-course-411501.green_taxi_data_2022.green_taxi_partitioned
WHERE lpep_pickup_date BETWEEN '2020-06-02' and '2022-06-30';
```

#### Question 6 Answer: 
* GCP Bucket

#### Question 7 Answer: 
* False