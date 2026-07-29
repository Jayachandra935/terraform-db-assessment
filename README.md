# Hotel Booking Infrastructure Assessment

## Project Overview

This project implements a production-ready infrastructure for a Hotel Booking application using Terraform, Docker Compose, PostgreSQL, and GitHub Actions.

The solution provisions reusable infrastructure modules, supports multiple environments (Development and Production), configures a PostgreSQL database with optimized schema and indexes, and provides automated backup and restore scripts.

---

# Technology Stack

- Terraform
- AWS
- Docker Compose
- PostgreSQL 16
- GitHub Actions
- PowerShell
- Bash

---

# Project Structure

```
terraform-db-assessment/
│
├── infra/
│   ├── envs/
│   │   ├── dev/
│   │   └── prod/
│   │
│   └── modules/
│       ├── network/
│       ├── security/
│       ├── alb/
│       ├── ecs/
│       └── rds/
│
├── database/
│   ├── migrations/
│   ├── seed/
│   └── optimization/
│
├── scripts/
│   ├── backup.ps1
│   ├── backup.sh
│   ├── restore.ps1
│   └── restore.sh
│
├── docker-compose.yml
└── .github/workflows/
```

---

# Infrastructure

The infrastructure is created using reusable Terraform modules.

Modules include:

- Network
- Security Groups
- Application Load Balancer
- ECS Fargate
- PostgreSQL RDS

Two environments are supported:

- Development
- Production

Environment-specific configurations include:

| Setting | Development | Production |
|----------|-------------|------------|
| ECS CPU | 256 | 512 |
| ECS Memory | 512 MB | 1024 MB |
| RDS Instance | db.t3.micro | db.t3.small |
| Backup Retention | 1 Day | 7 Days |
| Deletion Protection | Disabled | Enabled |

---

# Terraform Commands

Initialize Terraform

```bash
terraform init
```

Format configuration

```bash
terraform fmt
```

Validate configuration

```bash
terraform validate
```

Generate execution plan

```bash
terraform plan
```

---

# Database Setup

Start PostgreSQL

```bash
docker compose up -d
```

Run migration

```bash
docker exec -i hotel-postgres psql -U postgres -d hotelbooking < database/migrations/001_create_tables.sql
```

Load sample data

```bash
docker exec -i hotel-postgres psql -U postgres -d hotelbooking < database/seed/001_seed_data.sql
```

---

# Database Design

The solution contains two tables.

## hotel_bookings

Stores booking information including:

- Booking Reference
- Organization ID
- Hotel ID
- Guest Details
- Booking Status
- Amount
- Check-in / Check-out
- JSON Payload

## booking_events

Stores booking lifecycle events.

---

# Query Optimization

Indexes were created to improve frequently executed queries.

Indexes include:

- City
- Booking Status
- Check-in Date
- Booking Events
- Composite Index

Composite Index

```
(city, created_at, org_id, booking_status)
```

This index improves filtering by city, organization, booking status, and booking creation date.

---

# Backup

PowerShell

```powershell
.\scripts\backup.ps1
```

Linux

```bash
./scripts/backup.sh
```

Features

- Timestamped backups
- PostgreSQL pg_dump
- Backup stored in /backups

---

# Restore

PowerShell

```powershell
.\scripts\restore.ps1
```

Linux

```bash
./scripts/restore.sh
```

The restore script:

- Detects the latest backup automatically
- Drops existing schema
- Recreates schema
- Restores complete database

---

# Validation

Verify total bookings

```sql
SELECT COUNT(*) FROM hotel_bookings;
```

Verify booking events

```sql
SELECT COUNT(*) FROM booking_events;
```

Expected Result

```
100 rows
```

---

# GitHub Actions

CI pipeline performs:

- Terraform Format Check
- Terraform Validation
- Terraform Plan

---

# Assumptions

- AWS credentials are configured before running Terraform.
- Docker Desktop is installed.
- PostgreSQL runs locally through Docker Compose.
- Terraform is used for planning and validation only.
- Infrastructure is not applied as part of this assessment.

---

# Author

Jaya Chandra
