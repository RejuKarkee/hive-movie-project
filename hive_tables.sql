-- Movies external table
CREATE EXTERNAL TABLE movie_int (
  movieId INT,
  title STRING,
  genres STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = "\""
)
STORED AS TEXTFILE
LOCATION '/data/movies'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Managed movies table
CREATE TABLE movies (
  movieId INT,
  title STRING
)
PARTITIONED BY (genres STRING);

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.mapred.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=5000;
SET hive.exec.max.dynamic.partitions.pernode=5000;

INSERT INTO TABLE movies PARTITION (genres)
SELECT movieId, title, genres
FROM movie_int;

-- Ratings external table
CREATE EXTERNAL TABLE ratings_int (
  userId INT,
  movieId INT,
  rating FLOAT,
  rating_timestamp BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/ratings'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Managed ratings table
CREATE TABLE ratings (
  movieId INT,
  rating FLOAT,
  rating_timestamp BIGINT
)
PARTITIONED BY (userId INT)
CLUSTERED BY (rating) INTO 5 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

SET hive.enforce.bucketing=true;
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.mapred.mode=nonstrict;

INSERT INTO TABLE ratings PARTITION (userId)
SELECT movieId, rating, rating_timestamp, userId
FROM ratings_int;
