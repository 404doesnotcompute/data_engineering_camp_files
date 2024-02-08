
#### Question 1 Answer: 
* 266,855 rows x 20 columns
```
import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """

    url = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/tag/green/download'
    response = requests.get(url)

    taxi_dtypes = {
                    'VendorID' : pd.Int64Dtype(),
                    'passenger_count' : pd.Int64Dtype(),
                    'trip_distance' : float,
                    'RatecodeID' : pd.Int64Dtype(),
                    'store_and_fwd_flag' : str,
                    'PULocationID' : pd.Int64Dtype(),
                    'DOLocationID' : pd.Int64Dtype(),
                    'payment_type' : pd.Int64Dtype(),
                    'fare_amount' : float,
                    'ehail_fee' : float,
                    'extra' : float,
                    'mta_tax' : float,
                    'tip_amount' : float,
                    'tolls_amount' : float,
                    'improvement_surcharge' : float,
                    'total_amount' : float,
                    'trip_type': pd.Int64Dtype(),
                    'congestion_surcharge' : float
                }

    parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    urls = ['https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-10.csv.gz','https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-11.csv.gz','https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-12.csv.gz']


    joint_df = []

    for url in urls:
        dfs = pd.read_csv(url, sep=",", compression='gzip', dtype=taxi_dtypes, parse_dates=parse_dates) 
        joint_df.append(dfs)
    
    df = pd.concat(joint_df, axis=0)

    return df



@test
def test_output(output, *args) -> None:
    assert output is not None, 'The output is undefined'

```

#### Questions 2-4 Answers: 
2. 139,170 Rows
3. data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
4. 1 or 2

```
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data.columns = (data.columns
                    .str.replace(' ', '_')
                    .str.lower()
    
    )
    
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    return(data[(data['passenger_count'] >0) & (data['trip_distance'] != 0)]) 


@test
def test_output(output, *args) -> None:
    assert set(output).issuperset(['vendorid']), 'vendorid is not present in columns'


@test
def test_output(output, *args) -> None:
    assert output['passenger_count'].isin([0]).sum() == 0, 'There are rides with zero passengers'

@test
def test_output(output, *args) -> None:
    assert output['trip_distance'].isin([1]).sum() > 0, 'There are rides with zero distance'
```


#### Questions 5-6 Answers: 
5. 4
6. 96

```
import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = "/home/src/dtc-de-course-411501-ea78659304e8.json"

bucket_name = 'mage-zoomcamp-jorgerubio'
project_id = 'dtc-de-course-411501'


table_name = 'green_taxi_data'

root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data(data, *args, **kwargs):

    table =pa.Table.from_pandas(data)

    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=['lpep_pickup_date'],
        filesystem=gcs
    )
```

