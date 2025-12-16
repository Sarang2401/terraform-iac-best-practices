# Terraform IaC Best Practices

This repository demonstrates production-grade Terraform patterns focused on
**state management, safety, and scalability**, not just resource creation.

---

## Why this repository exists

Most Terraform failures in production are caused by:
- Shared or local state
- Missing state locking
- Environment coupling
- No drift detection
- Blind merges without validation

This repo shows how to avoid those failure modes.

---

## Repository Structure

terraform-iac-best-practices/
│
├── backend/
│   ├── s3.tf
│   ├── dynamodb.tf
│   └── outputs.tf
│
├── modules/
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│
├── envs/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── dev.tfvars
│   │
│   └── prod/
│       ├── backend.tf
│       ├── main.tf
│       ├── variables.tf
│       └── prod.tfvars
│
├── .github/
│   └── workflows/
│       └── terraform-plan.yml
│
├── scripts/
│   └── drift-check.sh
│
├── .gitignore
├── README.md
└── versions.tf


---

## Key Design Decisions

### 1. Remote State with Locking
- S3 backend for state storage
- DynamoDB for state locking
- Encryption enabled

This prevents:
- Concurrent applies
- State corruption
- Accidental local state

---

### 2. Environment Isolation
Each environment has:
- Its own backend
- Its own state file
- Its own variables

No shared state between prod and non-prod.

---

### 3. Modular Design
Infrastructure is built using reusable Terraform modules.
This avoids copy-paste and enables versioning.

---

### 4. Drift Detection
Terraform exit codes are used to detect infrastructure drift caused by
manual console changes.

---

### 5. CI Validation
On every pull request:
- Terraform init + plan runs
- Uses remote state
- Blocks unsafe merges

No Terraform apply happens in CI.

---

## What this repo does NOT do
- No manual console changes
- No terraform apply in CI
- No hardcoded secrets
