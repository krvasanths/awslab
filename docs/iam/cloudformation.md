# CloudFormation – deploy user permissions

Minimum IAM permissions for the deploy user to **create, update, delete, and inspect** CloudFormation stacks (used by the pipeline for all CFT deploys).

---

## Mapped CFT

| CFT / usage | Role |
|-------------|------|
| **All stacks** from [cft/templates/](../../cft/templates/) | Pipeline runs `aws cloudformation deploy` for every template; the deploy user needs stack lifecycle + change set actions. |
| *(No single template – CloudFormation is the deployment mechanism.)* | |

---

## What this user can do

- Create, update, and delete stacks.
- Describe stacks, stack events, and stack resources (for status and debugging).
- Create, describe, execute, and delete change sets (used by `aws cloudformation deploy`).
- Get and validate templates.
- List stacks and stack resources.

---

## Required actions

| Action | Purpose |
|--------|--------|
| `CreateStack`, `UpdateStack`, `DeleteStack` | Deploy and remove stacks. |
| `DescribeStacks`, `DescribeStackEvents`, `DescribeStackResources`, `DescribeStackResource` | Check status and debug failures. |
| `GetTemplate`, `ValidateTemplate` | Template handling. |
| `CreateChangeSet`, `DescribeChangeSet`, `ExecuteChangeSet`, `DeleteChangeSet` | How `aws cloudformation deploy` works. |
| `ListStacks`, `ListStackResources` | Listing. |

**Resource:** `*` (stacks are account-scoped).

---

## Policy file

**[../iam-policies/cloudformation.json](../iam-policies/cloudformation.json)** – attach this policy to the deploy user to allow CloudFormation only.

If your CFT creates IAM resources (roles/policies), you will also need an IAM policy document for those actions and `CAPABILITY_NAMED_IAM` in the pipeline; add a future `docs/iam/iam.md` when you add such templates.
