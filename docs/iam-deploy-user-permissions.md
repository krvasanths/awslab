# Minimum IAM permissions for deploy user

This doc has been **split by AWS service** for easier maintenance and to map permissions to CFT.

→ **See [iam/README.md](iam/README.md)** for the index, per-service docs, and policy files.

| Service | Doc | Policy |
|---------|-----|--------|
| CloudFormation | [iam/cloudformation.md](iam/cloudformation.md) | [iam-policies/cloudformation.json](iam-policies/cloudformation.json) |
| S3 | [iam/s3.md](iam/s3.md) | [iam-policies/s3.json](iam-policies/s3.json) |
| Lambda | [iam/lambda.md](iam/lambda.md) | [iam-policies/lambda.json](iam-policies/lambda.json) |
| API Gateway | [iam/apigateway.md](iam/apigateway.md) | [iam-policies/apigateway.json](iam-policies/apigateway.json) |
| SQS | [iam/sqs.md](iam/sqs.md) | [iam-policies/sqs.json](iam-policies/sqs.json) |
| SNS | [iam/sns.md](iam/sns.md) | [iam-policies/sns.json](iam-policies/sns.json) |
| Step Functions | [iam/stepfunctions.md](iam/stepfunctions.md) | [iam-policies/stepfunctions.json](iam-policies/stepfunctions.json) |

**Combined policy (all services):** [iam-policies/deploy-user-minimal-policy.json](iam-policies/deploy-user-minimal-policy.json)  
If you get *Maximum policy size of 2048 bytes exceeded*, attach the **four per-service policies** above as separate inline policies, or use a **customer managed policy**; see [iam/README.md](iam/README.md#inline-policy-size-limit-2048-bytes).

When you add new CFT that use other AWS services, add a new doc under `docs/iam/<service>.md` and a matching `docs/iam-policies/<service>.json`, then update the index in `docs/iam/README.md`.
