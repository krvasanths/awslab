# IAM permissions for deploy user (by AWS service)

Least-privilege permissions for the user or role that runs the deployment pipeline. Each AWS service has its own doc and policy file so we can add or remove services as we add CFT/TF.

---

## Service index

| AWS service       | Doc | Policy JSON | Mapped CFT |
|-------------------|-----|-------------|------------|
| **CloudFormation** | [cloudformation.md](cloudformation.md) | [../iam-policies/cloudformation.json](../iam-policies/cloudformation.json) | All stack deploys (pipeline) |
| **S3**            | [s3.md](s3.md) | [../iam-policies/s3.json](../iam-policies/s3.json) | [vasanthtest-bucket.yaml](../../cft/templates/vasanthtest-bucket.yaml) |
| **Lambda** | [lambda.md](lambda.md) | [../iam-policies/lambda.json](../iam-policies/lambda.json) | [api-gateway-lambda.yaml](../../cft/templates/api-gateway-lambda.yaml) |
| **API Gateway** | [apigateway.md](apigateway.md) | [../iam-policies/apigateway.json](../iam-policies/apigateway.json) | [api-gateway-lambda.yaml](../../cft/templates/api-gateway-lambda.yaml) |
| **SQS** | [sqs.md](sqs.md) | [../iam-policies/sqs.json](../iam-policies/sqs.json) | [sqs-queue.yaml](../../cft/templates/sqs-queue.yaml) |
| **SNS** | [sns.md](sns.md) | [../iam-policies/sns.json](../iam-policies/sns.json) | [sns-topic.yaml](../../cft/templates/sns-topic.yaml) |
| **Step Functions** | [stepfunctions.md](stepfunctions.md) | [../iam-policies/stepfunctions.json](../iam-policies/stepfunctions.json) | [state-machine.yaml](../../cft/templates/state-machine.yaml) |

When you add a new CFT that uses another service, add a new row here and a new `docs/iam/<service>.md` + `docs/iam-policies/<service>.json`.

---

## How to apply

**Option A – Combined (all services)**  
Attach one policy that includes every service the pipeline needs:

- **[deploy-user-minimal-policy.json](../iam-policies/deploy-user-minimal-policy.json)** – CloudFormation + S3 (and extend as you add services).

**Option B – Per service**  
Attach one policy per service so you can grant only what each CFT needs:

- Attach [cloudformation.json](../iam-policies/cloudformation.json) for stack lifecycle.
- Attach [s3.json](../iam-policies/s3.json) when you deploy templates that create or use S3 buckets.
- Attach [lambda.json](../iam-policies/lambda.json) and [apigateway.json](../iam-policies/apigateway.json) when you deploy the API Gateway + Lambda stack (or use [lambda-apigateway-iam.json](../iam-policies/lambda-apigateway-iam.json) for both in one policy).
- Attach [sqs.json](../iam-policies/sqs.json), [sns.json](../iam-policies/sns.json), [stepfunctions.json](../iam-policies/stepfunctions.json) when you deploy the SQS, SNS, and state machine stacks.

**CLI example (combined):**

```bash
aws iam put-user-policy \
  --user-name YOUR_DEPLOY_USER_NAME \
  --policy-name awslab-deploy-minimal \
  --policy-document file://docs/iam-policies/deploy-user-minimal-policy.json
```

---

### Inline policy size limit (2048 bytes)

**Error:** `Maximum policy size of 2048 bytes exceeded for user`  
IAM allows at most **2048 bytes per inline policy** per user. The combined [deploy-user-minimal-policy.json](../iam-policies/deploy-user-minimal-policy.json) is larger than that, so a single inline policy fails.

**Workaround 1 – Multiple inline policies (recommended)**  
Attach **four separate inline policies**, one per service. Each file is under 2048 bytes. Use distinct policy names:

| Policy name (e.g.) | Policy document file |
|-------------------|----------------------|
| `awslab-deploy-cfn` | [cloudformation.json](../iam-policies/cloudformation.json) |
| `awslab-deploy-s3` | [s3.json](../iam-policies/s3.json) |
| `awslab-deploy-lambda` | [lambda.json](../iam-policies/lambda.json) |
| `awslab-deploy-apigw` | [apigateway.json](../iam-policies/apigateway.json) |
| `awslab-deploy-sqs` | [sqs.json](../iam-policies/sqs.json) |
| `awslab-deploy-sns` | [sns.json](../iam-policies/sns.json) |
| `awslab-deploy-stepfunctions` | [stepfunctions.json](../iam-policies/stepfunctions.json) |

In **IAM → Users → your user → Permissions → Add permissions → Create inline policy → JSON**, paste **one** file at a time, set the policy name, then create. Repeat for all listed.

**Workaround 2 – Customer managed policy**  
Create a **customer managed policy** (not inline): **IAM → Policies → Create policy → JSON**, paste [deploy-user-minimal-policy.json](../iam-policies/deploy-user-minimal-policy.json). Customer managed policies have a **6144 byte** limit. Save the policy, then **Users → your user → Add permissions → Attach policies directly** and select that policy.

---

**Optional – Restrict S3 to specific buckets**  
See [s3.md](s3.md) for scoping resources to bucket name prefixes (e.g. `vasanthtest-*`).

---

## When you add more services

To avoid size limits as the repo grows, use **one customer managed policy per service** and attach them to the deploy user (or to a group the user is in). This scales without hitting the 2048-byte inline limit or the 6144-byte single-policy limit.

| Limit | Applies to |
|-------|------------|
| 2048 bytes | Each **inline** policy on a user/role/group |
| 6144 bytes | Each **customer managed** policy (standalone policy in IAM → Policies) |

**Recommended approach:**

1. **Do not use one giant inline or managed policy** for everything. The combined policy will eventually exceed 6144 bytes as you add services.
2. **Create one customer managed policy per service** from the per-service JSON files (e.g. `awslab-deploy-cfn`, `awslab-deploy-s3`, `awslab-deploy-lambda`, `awslab-deploy-apigw`). Each stays under 6144 bytes.
3. **Attach all of them** to the deploy user, or attach them to an IAM **group** (e.g. `awslab-deploy`) and put the user in that group. You can attach up to 10 managed policies per user (and 10 per group).
4. **When you add a new service** (e.g. DynamoDB, Step Functions):
   - Add `docs/iam/<service>.md` and `docs/iam-policies/<service>.json` (see [Convention](#convention) below).
   - Add a row to the [Service index](#service-index) table above.
   - In AWS: **IAM → Policies → Create policy → JSON**, paste the new `<service>.json`, name it (e.g. `awslab-deploy-dynamodb`), create, then **attach** it to the deploy user or to the `awslab-deploy` group.
   - Optionally update [deploy-user-minimal-policy.json](../iam-policies/deploy-user-minimal-policy.json) so it stays a reference of “all permissions”; if it grows past 6144 bytes, stop using it as a single attachable policy and rely only on per-service policies.

**Summary:** One customer managed policy per service, all attached to the user (or to one group). Adding a service = add doc + JSON + new managed policy + attach. No size-limit issue as long as each service’s JSON stays under 6144 bytes.

---

## Convention

- **One markdown file per service** under `docs/iam/<service>.md`.
- **One policy JSON per service** under `docs/iam-policies/<service>.json`.
- Each service doc has a **Mapped CFT** section listing which templates under `cft/templates/` use that service and which resources/actions they need.
- Keep this index and the combined policy in sync when adding or changing services.
