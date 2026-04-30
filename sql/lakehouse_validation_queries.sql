-- Lakehouse validation and analysis queries

SELECT 'bronze_claims_raw' AS table_name, COUNT(*) AS row_count FROM dbo.bronze_claims_raw
UNION ALL
SELECT 'bronze_policies_raw', COUNT(*) FROM dbo.bronze_policies_raw
UNION ALL
SELECT 'bronze_customers_raw', COUNT(*) FROM dbo.bronze_customers_raw
UNION ALL
SELECT 'bronze_vehicles_raw', COUNT(*) FROM dbo.bronze_vehicles_raw
UNION ALL
SELECT 'bronze_payments_raw', COUNT(*) FROM dbo.bronze_payments_raw
UNION ALL
SELECT 'silver_stg_claims', COUNT(*) FROM dbo.silver_stg_claims
UNION ALL
SELECT 'silver_stg_policies', COUNT(*) FROM dbo.silver_stg_policies
UNION ALL
SELECT 'silver_stg_customers', COUNT(*) FROM dbo.silver_stg_customers
UNION ALL
SELECT 'silver_stg_vehicles', COUNT(*) FROM dbo.silver_stg_vehicles
UNION ALL
SELECT 'silver_stg_payments', COUNT(*) FROM dbo.silver_stg_payments
UNION ALL
SELECT 'hub_claim', COUNT(*) FROM dbo.hub_claim
UNION ALL
SELECT 'hub_policy', COUNT(*) FROM dbo.hub_policy
UNION ALL
SELECT 'hub_customer', COUNT(*) FROM dbo.hub_customer
UNION ALL
SELECT 'hub_vehicle', COUNT(*) FROM dbo.hub_vehicle
UNION ALL
SELECT 'hub_payment', COUNT(*) FROM dbo.hub_payment
UNION ALL
SELECT 'link_claim_policy', COUNT(*) FROM dbo.link_claim_policy
UNION ALL
SELECT 'link_policy_customer', COUNT(*) FROM dbo.link_policy_customer
UNION ALL
SELECT 'link_claim_vehicle', COUNT(*) FROM dbo.link_claim_vehicle
UNION ALL
SELECT 'link_claim_payment', COUNT(*) FROM dbo.link_claim_payment
UNION ALL
SELECT 'sat_claim_details', COUNT(*) FROM dbo.sat_claim_details
UNION ALL
SELECT 'sat_policy_coverage', COUNT(*) FROM dbo.sat_policy_coverage
UNION ALL
SELECT 'sat_customer_profile', COUNT(*) FROM dbo.sat_customer_profile
UNION ALL
SELECT 'sat_vehicle_attributes', COUNT(*) FROM dbo.sat_vehicle_attributes
UNION ALL
SELECT 'sat_payment_details', COUNT(*) FROM dbo.sat_payment_details
UNION ALL
SELECT 'dm_claim_360', COUNT(*) FROM dbo.dm_claim_360
UNION ALL
SELECT 'dm_claim_history_timeline', COUNT(*) FROM dbo.dm_claim_history_timeline
UNION ALL
SELECT 'dm_fraud_support_case', COUNT(*) FROM dbo.dm_fraud_support_case
ORDER BY table_name;

SELECT 'hub_claim' AS hub_name,
       COUNT(*) AS total_rows,
       COUNT(DISTINCT claim_hk) AS distinct_hash_keys,
       COUNT(DISTINCT claim_number) AS distinct_business_keys
FROM dbo.hub_claim
UNION ALL
SELECT 'hub_policy',
       COUNT(*),
       COUNT(DISTINCT policy_hk),
       COUNT(DISTINCT policy_number)
FROM dbo.hub_policy
UNION ALL
SELECT 'hub_customer',
       COUNT(*),
       COUNT(DISTINCT customer_hk),
       COUNT(DISTINCT customer_id)
FROM dbo.hub_customer
UNION ALL
SELECT 'hub_vehicle',
       COUNT(*),
       COUNT(DISTINCT vehicle_hk),
       COUNT(DISTINCT vin)
FROM dbo.hub_vehicle
UNION ALL
SELECT 'hub_payment',
       COUNT(*),
       COUNT(DISTINCT payment_hk),
       COUNT(DISTINCT payment_number)
FROM dbo.hub_payment;

SELECT
    l.claim_policy_hk,
    hc.claim_number,
    hp.policy_number
FROM dbo.link_claim_policy l
LEFT JOIN dbo.hub_claim hc
    ON l.claim_hk = hc.claim_hk
LEFT JOIN dbo.hub_policy hp
    ON l.policy_hk = hp.policy_hk;

SELECT TOP 20 *
FROM dbo.dm_claim_360
ORDER BY claim_number;

SELECT TOP 20 *
FROM dbo.dm_fraud_support_case
ORDER BY suspected_fraud_flag DESC, claim_amount DESC;

SELECT claim_status, COUNT(*) AS claim_count
FROM dbo.dm_claim_360
GROUP BY claim_status
ORDER BY claim_count DESC;

SELECT loss_type, AVG(CAST(claim_amount AS DECIMAL(12,2))) AS avg_claim_amount
FROM dbo.dm_claim_360
GROUP BY loss_type
ORDER BY avg_claim_amount DESC;

SELECT suspected_fraud_flag, COUNT(*) AS case_count
FROM dbo.dm_fraud_support_case
GROUP BY suspected_fraud_flag;
