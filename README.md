# Hive Movie Analytics Project

This project demonstrates a simple data engineering pipeline using **Apache Hive** on Hadoop.

## Dataset

The project uses the MovieLens dataset:

- `movies.csv`
- `ratings.csv`

These datasets contain movie information and user ratings.

## Architecture

Raw data is stored in HDFS and accessed using **external tables**.

Two layers were implemented:

### External Tables (Raw Layer)

- `movie_int`
- `ratings_int`

These tables read raw CSV files from HDFS.

### Managed Tables (Processed Layer)

- `movies`
- `ratings`

These tables store structured data in the Hive warehouse.

## Data Engineering Concepts Practiced

### Partitioning

`movies` table is partitioned by:genres


`ratings` table is partitioned by:userId


Partitioning improves query performance by reducing the amount of data scanned.

### Bucketing

The `ratings` table is bucketed by:rating into **5 buckets** to improve query efficiency.

## Example Analytical Queries

Examples include:

- Movies and number of ratings
- Users and number of ratings
- Movies with min, max, and average rating
- Users with min, max, and average rating

These queries demonstrate how Hive can be used for large-scale analytical workloads.

## Technologies Used

- Apache Hive
- Hadoop HDFS
- Docker
- SQL

## Learning Outcome

This project demonstrates key data engineering concepts such as:

- External vs managed tables
- Data partitioning
- Bucketing
- Hive SQL analytics
- Working with datasets stored in HDFS
