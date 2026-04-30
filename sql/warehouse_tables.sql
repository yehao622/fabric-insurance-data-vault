-- Warehouse table creation queries

CREATE TABLE dbo.wh_claim_360
AS
SELECT *
FROM lh_insurance_bronze_silver.dbo.dm_claim_360;

CREATE TABLE dbo.wh_claim_history_timeline
AS
SELECT *
FROM lh_insurance_bronze_silver.dbo.dm_claim_history_timeline;

CREATE TABLE dbo.wh_fraud_support_case
AS
SELECT *
FROM lh_insurance_bronze_silver.dbo.dm_fraud_support_case;
