
#### Question 1 Answer: 
```
--rm
```

#### Question 2 Answer: 
```
docker run -it --entrypoint=bash python:3.9

root@5da61a698fa8:/# pip list
Package    Version
---------- -------
pip        23.0.1
setuptools 58.1.0
wheel      0.42.0

[notice] A new release of pip is available: 23.0.1 -> 23.3.2
[notice] To update, run: pip install --upgrade pip
```

#### Question 3 Answer: 
```
--QUESTION 3 HW WEEK 1 
SELECT COUNT(*) 
FROM green_taxi_data
WHERE DATE("lpep_pickup_datetime") = '2019-09-18'AND DATE("lpep_dropoff_datetime") = '2019-09-18';
```

#### Question 4 Answer: 
```
--QUESTION 4 HW WEEK 1 
SELECT DATE(lpep_pickup_datetime) AS pickup_day, 
MAX(CAST(trip_distance AS NUMERIC)) AS max_trip_distance
FROM green_taxi_data
GROUP BY 1 ORDER BY 2 DESC;
```

#### Question 5 Answer: 
```
--QUESTION 5 HW WEEK 1 
SELECT zo."Borough",
        sum(CAST(gtd.total_amount AS NUMERIC)) as total_tip
FROM green_taxi_data gtd
INNER JOIN zones zo
ON gtd."PULocationID" = zo."LocationID"
WHERE DATE("lpep_pickup_datetime") = '2019-09-18'
AND DATE("lpep_dropoff_datetime") = '2019-09-18'
AND zo."Borough" <> 'Unknown'
GROUP BY 1;
```

#### Question 6 Answer: 
```
--QUESTION 6 HW WEEK 1 
SELECT pzo."Zone" AS pickup_zone,
        dzo."Zone" AS dropoff_zone,
        MAX(gtd.tip_amount) as total_tip_amount
FROM green_taxi_data gtd
INNER JOIN zones pzo
ON gtd."PULocationID" = pzo."LocationID"
INNER JOIN zones dzo
ON gtd."DOLocationID" = dzo."LocationID"
WHERE DATE("lpep_pickup_datetime") BETWEEN '2019-09-01' AND '2019-09-30'
AND pzo."Zone" = 'Astoria'
GROUP BY 1,2
ORDER BY 3 DESC;
```

#### Question 7 Answer: 
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.demo_dataset will be created
  + resource "google_bigquery_dataset" "demo_dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "example_dataset"
      + default_collation          = (known after apply)
      + delete_contents_on_destroy = false
      + effective_labels           = (known after apply)
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + is_case_insensitive        = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "US"
      + max_time_travel_hours      = (known after apply)
      + project                    = "mimetic-math-411501"
      + self_link                  = (known after apply)
      + storage_billing_model      = (known after apply)
      + terraform_labels           = (known after apply)
    }

  # google_storage_bucket.demo-bucket will be created
  + resource "google_storage_bucket" "demo-bucket" {
      + effective_labels            = (known after apply)
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "US"
      + name                        = "mimetic-math-411501-terra-bucket"
      + project                     = (known after apply)
      + public_access_prevention    = (known after apply)
      + rpo                         = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + terraform_labels            = (known after apply)
      + uniform_bucket_level_access = (known after apply)
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "AbortIncompleteMultipartUpload"
            }
          + condition {
              + age                   = 1
              + matches_prefix        = []
              + matches_storage_class = []
              + matches_suffix        = []
              + with_state            = (known after apply)
            }
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.demo_dataset: Creating...
google_storage_bucket.demo-bucket: Creating...
google_bigquery_dataset.demo_dataset: Creation complete after 1s [id=projects/mimetic-math-411501/datasets/example_dataset]
google_storage_bucket.demo-bucket: Creation complete after 1s [id=mimetic-math-411501-terra-bucket]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```
