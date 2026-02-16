# TF – AWS Service Provisioning (Terraform)

This folder contains **Terraform** configurations for provisioning AWS services.

## Usage

- Add modules and environments under `modules/` and `environments/` (or as you prefer).
- Infrastructure is applied by the repo **deployment pipeline** when changes are **merged to the `main` branch** (PR merge only).

## Structure

```
tf/
├── modules/       # Reusable Terraform modules (optional)
├── environments/  # env-specific tfvars (e.g. dev, prod)
├── main.tf        # Root module / entrypoint
├── variables.tf
├── outputs.tf
├── backend.tf     # S3 + DynamoDB backend (configure for your account)
└── README.md
```

## Backend

Configure `backend.tf` with your S3 bucket and DynamoDB table for state. The pipeline needs access to this backend (e.g. OIDC or stored credentials).

## Pipeline

The pipeline runs `terraform init`, `terraform plan`, and `terraform apply` only on push to `main` (after PR merge), and only when changes under `tf/` are detected.
