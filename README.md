# awslab

Repository for AWS infrastructure: CloudFormation templates (CFT) and Terraform (TF), with deployment only from the **main** branch (via PR merge).

## Structure

| Folder | Purpose |
|--------|--------|
| **aws-service-enablement/** | CFT for access, permissions, and permission boundaries (future). Enable services and IAM before provisioning workloads. |
| **cft/** | CloudFormation templates for provisioning AWS services (VPC, S3, Lambda, etc.). |
| **tf/** | Terraform for provisioning AWS services. |

## Deployment pipeline

- **Only merges to `main`** trigger deployment (e.g. merge a PR into `main`).
- Pushes to feature branches or PR updates do **not** deploy.
- Pipeline runs under `.github/workflows/deploy.yml` and deploys only the area that changed (enablement, CFT, or TF).

See [.github/workflows/README.md](.github/workflows/README.md) for trigger rules, jobs, and how to set AWS credentials (OIDC or secrets).

## Quick start

1. **Enablement:** Add CFT under `aws-service-enablement/templates/` when you need IAM or permission boundaries.
2. **CFT:** Add stack templates under `cft/templates/`; the pipeline deploys them on merge to `main`.
3. **TF:** Edit `tf/` (e.g. `main.tf`, `variables.tf`). Configure `tf/backend.tf` with your S3 state bucket for CI. Merge to `main` to apply.

Configure repo secrets (e.g. `AWS_ROLE_ARN` for OIDC) and optional branch protection so only PRs to `main` can merge.
