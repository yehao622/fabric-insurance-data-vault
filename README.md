# Insurance Claims Data Vault in Microsoft Fabric

End-to-end Microsoft Fabric project for an insurance analytics pipeline built with Lakehouse notebooks, Data Vault 2.0 modeling, and a final curated warehouse output for claim 360 and fraud-support analysis.

## Why this project exists
Insurance data usually arrives from multiple operational sources and needs to be standardized, historized, and curated before it can support analytics or investigation workflows. This project shows how raw claims data can be turned into a governed warehouse-ready model using Fabric.

## What it demonstrates
- Microsoft Fabric Lakehouse development.
- Data Vault 2.0 modeling with hubs, links, and satellites.
- Notebook-based orchestration.
- Curated analytical marts for claim 360 and fraud support.
- Warehouse publishing as the final SQL-accessible output layer.

## Business scenario
The project uses an insurance domain with these core entities:
- Claims
- Policies
- Customers
- Vehicles
- Payments

The main goal is to answer questions like:
- Which policy is tied to a claim?
- Which customer and vehicle belong to that claim?
- What descriptive history changed over time?
- Which claims look suspicious based on patterns and context?

## Architecture
The pipeline follows a layered Fabric design:

1. **Bronze** — raw source ingestion.
2. **Silver** — standardization and cleanup.
3. **Raw Vault** — hubs, links, and satellites.
4. **Gold marts** — claim 360, history timeline, and fraud-support outputs.
5. **Warehouse** — final curated tables for SQL consumers.

## Data Vault model
### Hubs
Hubs store the business keys for the core objects, such as claim, policy, customer, vehicle, and payment.

### Links
Links store the relationships between hubs, such as claim-to-policy, policy-to-customer, claim-to-vehicle, and claim-to-payment.

### Satellites
Satellites store descriptive attributes and history, such as claim status, coverage information, customer profile details, vehicle attributes, and payment details.

## Repository contents
- `README.md` — project overview and workflow.
- Fabric notebooks for Bronze, Silver, Raw Vault, marts, and warehouse publish.
- Warehouse tables for final curated outputs.
- Screenshots showing the completed Fabric pipeline and warehouse results.

## Pipeline flow
The Fabric pipeline runs these steps:
1. `01_bronze_ingest`
2. `02_silver_standardize`
3. `03_load_raw_vault`
4. `04_build_claim360_and_fraud_mart`
5. `05_publish_to_warehouse`

## Final outputs
The final warehouse layer contains these business-facing tables:
- `wh_claim_360`
- `wh_claim_history_timeline`
- `wh_fraud_support_case`

These tables are intended for downstream SQL queries, reporting, and portfolio demonstration.

## Validation
The project was validated in Microsoft Fabric by confirming:
- source ingestion completed,
- transformations completed,
- Raw Vault tables were populated,
- gold marts were created,
- warehouse tables were published successfully,
- and the final SQL queries returned the expected results.

## Tech stack
- Microsoft Fabric
- Lakehouse
- Warehouse
- T-SQL notebooks
- Data Pipeline orchestration
- Data Vault 2.0
- SQL validation

## Screenshots

![Pipeline orchestration](screenshots/pipeline.jpg)
![Warehouse publish result](screenshots/publish-result-2.jpg)
![Warehouse tables](screenshots/warehouse-3.jpg)

## Future improvements
Possible next steps include:
- incremental loads,
- more historization scenarios,
- Power BI dashboards,
- automated data quality checks,
- and deployment/versioning for the Fabric artifacts.
