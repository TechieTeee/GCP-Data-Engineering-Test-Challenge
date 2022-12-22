#CleanandPruneData
Select
  pickup_datetime,
  pickup_longitude AS pickuplon,
  pickup_latitude AS pickuplat,
  dropoff_longitude AS dropofflon,
  dropoff_latitude AS dropofflat,
  passenger_count AS passengers,
  ( tolls_amount + fare_amount ) AS fare_amount_478
FROM
  `taxirides.historical_taxi_rides_raw`
WHERE
  trip_distance > 1
  AND fare_amount > 2.0
  AND pickup_longitude > -75
  AND pickup_longitude < -73
  AND dropoff_longitude > -75
  AND dropoff_longitude < -73
  AND pickup_latitude > 40
  AND pickup_latitude < 42
  AND dropoff_latitude > 40
  AND dropoff_latitude < 42
  AND passenger_count > 1
  AND RAND() < 999999 / 1031673361


#CreateModel
CREATE or REPLACE MODEL
  taxirides.fare_model_767 OPTIONS (model_type='linear_reg',
    labels=['fare_amount_478']) AS
WITH
  taxitrips AS (
  SELECT
    *,
    ST_Distance(ST_GeogPoint(pickuplon, pickuplat), ST_GeogPoint(dropofflon, dropofflat)) AS euclidean
  FROM
    `taxirides.taxi_training_data_985` )
  SELECT
    *
  FROM
    taxitrips
