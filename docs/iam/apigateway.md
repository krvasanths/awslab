# API Gateway – deploy user permissions

Minimum IAM permissions for the deploy user to create and manage **API Gateway REST APIs** (resources, methods, deployments, stages). Used when deploying stacks that include API Gateway (e.g. API Gateway + Lambda).

---

## Mapped CFT

| CFT template | Resources | Permissions used |
|--------------|-----------|-------------------|
| [cft/templates/api-gateway-lambda.yaml](../../cft/templates/api-gateway-lambda.yaml) | `AWS::ApiGateway::RestApi`, `AWS::ApiGateway::Resource`, `AWS::ApiGateway::Method`, `AWS::ApiGateway::Deployment`, `AWS::ApiGateway::Stage` | API Gateway GET/POST/PUT/PATCH/DELETE on restapis. |

---

## What this user can do

- Create and delete REST APIs.
- Create and manage resources, methods, integrations, deployments, and stages.

---

## Required actions

| Action | Purpose |
|--------|--------|
| `apigateway:GET`, `POST`, `PUT`, `PATCH`, `DELETE` | Create/update/delete API, resources, methods, deployments, stages. |

**Resource:** `arn:aws:apigateway:*::/restapis` and `arn:aws:apigateway:*::/restapis/*`

---

## Policy file

**[../iam-policies/apigateway.json](../iam-policies/apigateway.json)** – API Gateway only. Attach when you deploy stacks that create REST APIs.
