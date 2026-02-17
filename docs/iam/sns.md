# SNS – deploy user permissions

Minimum IAM permissions for the deploy user to create and manage **SNS topics** used by this repo’s CFT.

---

## Mapped CFT

| CFT template | Resources | Permissions used |
|--------------|-----------|-------------------|
| [cft/templates/sns-topic.yaml](../../cft/templates/sns-topic.yaml) | `AWS::SNS::Topic` | CreateTopic, DeleteTopic, GetTopicAttributes, SetTopicAttributes, ListTopics, ListSubscriptionsByTopic, Subscribe, Unsubscribe. |

---

## What this user can do

- Create and delete topics.
- Get and set topic attributes, list topics.
- List subscriptions and create/remove subscriptions.

---

## Required actions

| Action | Purpose |
|--------|--------|
| `CreateTopic`, `DeleteTopic` | Create and remove topics. |
| `GetTopicAttributes`, `SetTopicAttributes` | Read and update topic config. |
| `ListTopics`, `ListSubscriptionsByTopic` | List. |
| `Subscribe`, `Unsubscribe` | Manage subscriptions. |

**Resource:** `arn:aws:sns:*:*:awslab-*`

---

## Policy file

**[../iam-policies/sns.json](../iam-policies/sns.json)** – SNS only. Attach when you deploy the SNS stack.
