# 🏠 Airbnb Analytics — dbt + Snowflake

An end-to-end ELT data pipeline for Airbnb data, built with **dbt (Data Build Tool)** and **Snowflake**, following the **Medallion Architecture** (Bronze → Silver → Gold).

## 🏗️ Architecture

```
Sources (Snowflake)          Bronze              Silver                Gold
┌──────────────┐      ┌───────────────┐   ┌──────────────────┐   ┌──────────────┐
│  bookings    │ ──►  │bronze_bookings│──►│ silver_bookings  │──►│     OBT      │──► fact
│  listings    │ ──►  │bronze_listings│──►│ silver_listings  │──►│ (One Big     │
│  hosts       │ ──►  │bronze_hosts   │──►│ silver_hosts     │──►│  Table)      │
└──────────────┘      └───────────────┘   └──────────────────┘   └──────────────┘
                        (incremental)       (transformations)     (metadata-driven
                                                                   joins)
                                                                 ┌──────────────┐
                                                                 │  Snapshots   │
                                                                 │ (SCD Type 2) │
                                                                 │ dim_bookings │
                                                                 │ dim_listings │
                                                                 │ dim_hosts    │
                                                                 └──────────────┘
```

## 📂 Project Structure

| Folder | Purpose |
|--------|---------|
| `models/sources/` | Source definitions (Snowflake staging tables) |
| `models/bronze/` | Raw data ingestion with incremental loading |
| `models/silver/` | Business logic, transformations, and data cleaning |
| `models/gold/` | Analytics-ready tables — OBT, fact tables, ephemeral models |
| `snapshots/` | SCD Type 2 dimension tables (dim_bookings, dim_listings, dim_hosts) |
| `macros/` | Reusable Jinja macros (tag, multiply, trimmer, schema generation) |
| `analyses/` | Ad-hoc Jinja explorations (if/else, for loops) |
| `tests/` | Custom data quality tests |

## ✨ Key Features

- **Medallion Architecture** — Clean separation of raw, transformed, and analytics-ready data
- **Incremental Models** — Bronze and Silver layers use incremental materialization for efficient processing
- **Metadata-Driven Pipeline** — Gold OBT uses a config-driven Jinja pattern to dynamically generate joins
- **SCD Type 2 Snapshots** — Track historical changes in dimension tables using timestamp strategy
- **Custom Macros** — Reusable Jinja macros for pricing tags, calculations, and string operations
- **Ephemeral Models** — Lightweight CTEs in the Gold layer to reduce Snowflake compute costs

## 🛠️ Tech Stack

- **dbt Core** — Data transformation and modeling
- **Snowflake** — Cloud data warehouse
- **Jinja** — Templating for dynamic SQL generation

## 🚀 Getting Started

```bash
# Clone the repo
git clone <repo-url>
cd dbt_snowflake_project

# Install dependencies
pip install dbt-snowflake

# Configure your Snowflake connection in profiles.yml

# Run the pipeline
dbt run

# Run snapshots
dbt snapshot

# Run tests
dbt test
```
