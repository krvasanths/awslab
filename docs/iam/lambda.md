# Lambda – deploy user permissions

Minimum IAM permissions for the deploy user to create and manage **Lambda functions** and the **IAM execution roles** that Lambda assumes (e.g. for CloudWatch Logs). Used when deploying stacks that include Lambda (e.g. API Gateway + Lambda).

---

## Mapped CFT

| CFT template | Resources | Permissions used |
|--------------|-----------|-------------------|
| [cft/templates/api-gateway-lambda.yaml](../../cft/templates/api-gateway-lambda.yaml) | `AWS::Lambda::Function`, `AWS::Lambda::Permission`, `AWS::IAM::Role` | Lambda create/update/delete/get/add permission; IAM CreateRole, PassRole, AttachRolePolicy for the Lambda execution role. |

---

## What this user can do

- **Lambda:** Create, update, delete, and get functions; add/remove resource-based permissions (e.g. for API Gateway to invoke).
- **IAM:** Create/delete roles and attach/detach policies for Lambda execution roles (scoped to `awslab-*`).

---

## Required actions

### Lambda

| Action | Purpose |
|--------|--------|
| `CreateFunction`, `DeleteFunction`, `UpdateFunctionCode`, `UpdateFunctionConfiguration` | Deploy and update the function. |
| `GetFunction`, `GetFunctionConfiguration`, `ListVersionsByFunction` | Describe and list. |
| `AddPermission`, `RemovePermission` | Allow API Gateway (or other services) to invoke the function. |

**Resource:** `arn:aws:lambda:*:*:function:awslab-*`

### IAM (Lambda execution role)

| Action | Purpose |
|--------|--------|
| `CreateRole`, `DeleteRole`, `GetRole`, `PassRole` | Create the role Lambda assumes; PassRole is required for Lambda. |
| `AttachRolePolicy`, `DetachRolePolicy`, `PutRolePolicy`, `DeleteRolePolicy`, `GetRolePolicy` | Attach managed or inline policies to the role. |

**Resource:** `arn:aws:iam::*:role/awslab-*`

---

## Policy file

**[../iam-policies/lambda.json](../iam-policies/lambda.json)** – Lambda + IAM for Lambda roles. Attach when you deploy stacks that create Lambda functions.

The pipeline uses `--capabilities CAPABILITY_NAMED_IAM` so CloudFormation can create the role; the deploy user must have the IAM actions above.
