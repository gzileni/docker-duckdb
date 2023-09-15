   INSTALL spatial;
INSTALL httpfs;
INSTALL postgres;
LOAD spatial;
LOAD httpfs;
LOAD postgres;
SET s3_region='us-west-2';

   SELECT
           type,
           subType,
           localityType,
           adminLevel,
           isoCountryCodeAlpha2,
           JSON(names) AS names,
           JSON(sources) AS sources,
           ST_GeomFromWkb(geometry) AS geometry
      FROM read_parquet('s3://overturemaps-us-west-2/release/2023-07-26-alpha.0/theme=places/type=*/*', filename=true, hive_partitioning=1)
     WHERE adminLevel = 2
       AND ST_GeometryType(ST_GeomFromWkb(geometry)) IN ('POLYGON','MULTIPOLYGON')