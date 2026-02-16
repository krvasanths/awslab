# IAM permissions for deploy user (by AWS service)

Least-privilege permissions for the user or role that runs the deployment pipeline. Each AWS service has its own doc and policy file so we can add or remove services as we add CFT/TF.

---

## Service index

| AWS service       | Doc | Policy JSON | Mapped CFT |
|-------------------|-----|-------------|------------|
| **CloudFormation** | [cloudformation.md](cloudformation.md) | [../iam-policies/cloudformation.json](../iam-policies/cloudformation.json) | All stack deploys (pipeline) |
| **S3**            | [s3.md](s3.md) | [../iam-policies/s3.json](../iam-policies/s3.json) | [vasanthtest-bucket.yaml](../../cft/templates/vasanthtest-bucket.yaml) |

When you add a new CFT that uses another service (e.g. Lambda, IAM), add a new row here and a new `docs/iam/<service>.md` + `docs/iam-policies/<service>.json`.

---

## How to apply

**Option A – Combined (all services)**  
Attach one policy that includes every service the pipeline needs:

- **[deploy-user-minimal-policy.json](../iam-policies/deploy-user-minimal-policy.json)** – CloudFormation + S3 (and extend as you add services).

**Option B – Per service**  
Attach one policy per service so you can grant only what each CFT needs:

- Attach [cloudformation.json](../iam-policies/cloudformation.json) for stack lifecycle.
- Attach [s3.json](../iam-policies/s3.json) when you deploy templates that create or use S3 buckets.

**CLI example (combined):**

```bash
aws iam put-user-policy \
  --user-name YOUR_DEPLOY_USER_NAME \
  --policy-name awslab-deploy-minimal \
  --policy-document file://docs/iam-policies/deploy-user-minimal-policy.json
```

**Optional – Restrict S3 to specific buckets**  
See [s3.md](s3.md) for scoping resources to bucket name prefixes (e.g. `vasanthtest-*`).

---

## Convention

- **One markdown file per service** under `docs/iam/<service>.md`.
- **One policy JSON per service** under `docs/iam-policies/<service>.json`.
- Each service doc has a **Mapped CFT** section listing which templates under `cft/templates/` use that service and which resources/actions they need.
- Keep this index and the combined policy in sync when adding or changing services.
