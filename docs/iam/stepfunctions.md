# Step Functions – deploy user permissions

Minimum IAM permissions for the deploy user to create and manage **Step Functions state machines** used by this repo’s CFT. The state machine’s execution role is created by the template; the deploy user needs IAM role permissions (already covered by [lambda.json](../iam-policies/lambda.json) for `awslab-*` roles).

---

## Mapped CFT

| CFT template | Resources | Permissions used |
|--------------|-----------|-------------------|
| [cft/templates/state-machine.yaml](../../cft/templates/state-machine.yaml) | `AWS::StepFunctions::StateMachine`, `AWS::IAM::Role` | CreateStateMachine, DeleteStateMachine, UpdateStateMachine, DescribeStateMachine, ListStateMachines. IAM role creation uses the same `awslab-*` role permissions as Lambda. |

---

## What this user can do

- Create, update, and delete state machines.
- Describe and list state machines.

---

## Required actions

| Action | Purpose |
|--------|--------|
| `CreateStateMachine`, `DeleteStateMachine`, `UpdateStateMachine` | Deploy and update the state machine. |
| `DescribeStateMachine`, `ListStateMachines` | Describe and list. |

**Resource:** `arn:aws:states:*:*:stateMachine:awslab-*`

---

## Policy file

**[../iam-policies/stepfunctions.json](../iam-policies/stepfunctions.json)** – Step Functions only. Attach when you deploy the state machine stack. The template also creates an IAM role; ensure the deploy user has [lambda.json](../iam-policies/lambda.json) (or IAM for `awslab-*` roles) so it can create the state machine role.
