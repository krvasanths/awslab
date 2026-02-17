# SQS – deploy user permissions

Minimum IAM permissions for the deploy user to create and manage **SQS queues** used by this repo’s CFT.

---

## Mapped CFT

| CFT template | Resources | Permissions used |
|--------------|-----------|-------------------|
| [cft/templates/sqs-queue.yaml](../../cft/templates/sqs-queue.yaml) | `AWS::SQS::Queue` | CreateQueue, DeleteQueue, GetQueueUrl, GetQueueAttributes, SetQueueAttributes, ListQueues, tag actions. |

---

## What this user can do

- Create and delete queues.
- Get queue URL and attributes, set attributes.
- List queues and manage queue tags.

---

## Required actions

| Action | Purpose |
|--------|--------|
| `CreateQueue`, `DeleteQueue` | Create and remove queues. |
| `GetQueueUrl`, `GetQueueAttributes`, `SetQueueAttributes` | Read and update queue config. |
| `ListQueues`, `ListQueueTags`, `TagQueue`, `UntagQueue` | List and tag. |

**Resource:** `arn:aws:sqs:*:*:awslab-*`

---

## Policy file

**[../iam-policies/sqs.json](../iam-policies/sqs.json)** – SQS only. Attach when you deploy the SQS stack.
