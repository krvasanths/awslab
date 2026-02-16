# Minimum IAM permissions for deploy user

This doc has been **split by AWS service** for easier maintenance and to map permissions to CFT.

→ **See [iam/README.md](iam/README.md)** for the index, per-service docs, and policy files.

| Service | Doc | Policy |
|---------|-----|--------|
| CloudFormation | [iam/cloudformation.md](iam/cloudformation.md) | [iam-policies/cloudformation.json](iam-policies/cloudformation.json) |
| S3 | [iam/s3.md](iam/s3.md) | [iam-policies/s3.json](iam-policies/s3.json) |

**Combined policy (all services):** [iam-policies/deploy-user-minimal-policy.json](iam-policies/deploy-user-minimal-policy.json)

When you add new CFT that use other AWS services, add a new doc under `docs/iam/<service>.md` and a matching `docs/iam-policies/<service>.json`, then update the index in `docs/iam/README.md`.
