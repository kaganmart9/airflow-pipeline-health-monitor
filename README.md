# Airflow Pipeline Health Monitor (APHM)

## Problem statement

Apache Airflow pipelines often degrade in production due to:

- runtime regressions
- failure and retry spikes
- scheduler backlog and timeliness issues
- silent quality degradation

APHM builds an end-to-end system that extracts Airflow metadata (DagRun, TaskInstance, TaskFail), ingests it incrementally, produces governed features, detects anomalies (rules + IsolationForest), computes health scores, and serves results via an API and a UI.

## Architecture

Components:

- Airflow Lab: local Airflow instance to generate real metadata
- Exporter: extracts metadata to Parquet
- App DB: PostgreSQL feature store and governance tables
- Feature pipeline: canonical schema, validation, rolling features
- Anomaly detection: baseline rules + IsolationForest
- API: FastAPI service
- UI: Streamlit dashboard

High-level data flow:

1. Airflow writes metadata to its metadata DB
2. Exporter pulls metadata and writes Parquet to data/raw/
3. Ingestion loads Parquet to App DB incrementally
4. Feature pipeline validates schema and builds feature store tables
5. Models detect anomalies and compute health scores
6. API and UI serve health and anomaly insights

## Local development

This section will be expanded after the environment and docker-compose are added.

## Tests

This section will be expanded after pytest is wired.

## Deployment

This section will be expanded after Dockerfiles and Cloud Run config are added.
