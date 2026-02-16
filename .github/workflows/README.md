# Deployment pipeline

Deploys to AWS **only when changes are merged to the `main` branch** (i.e. after a PR is merged). Pushing to feature branches or updating a PR does **not** trigger deployment.

## Trigger

- **Event:** `push` to `main`
- **Paths:** Workflow runs only if changed files are under:
  - `aws-service-enablement/`
  - `cft/`
  - `tf/`
  - `.github/workflows/deploy.yml`

## Jobs

| Job | When it runs | What it does |
|-----|----------------|---------------|
| **changes** | Every run | Detects which of enablement, cft, or tf had changes |
| **deploy-enablement** | When `aws-service-enablement/**` changed | Deploys enablement CFT (placeholder until templates are added) |
| **deploy-cft** | When `cft/**` changed | Deploys all CloudFormation stacks in `cft/templates/` |
| **deploy-tf** | When `tf/**` changed | Runs `terraform init`, `plan`, `apply` in `tf/` |

## AWS credentials (access keys)

The workflow uses **access keys**. Add these repo **Secrets** (Settings → Secrets and variables → Actions):

| Secret name | Description |
|-------------|-------------|
| `AWS_ACCESS_KEY_ID` | Access key ID from your IAM user |
| `AWS_SECRET_ACCESS_KEY` | Secret access key (shown only once when created) |

### How to create access keys in AWS

1. Sign in to the **AWS Console** → **IAM** → **Users**.
2. Create a user for the pipeline (e.g. `github-awslab-deploy`) or pick an existing user.
3. Attach permissions (e.g. a policy that allows `cloudformation:*`, `s3:*`, `terraform` resources you need, or start with **AdministratorAccess** for a lab).
4. Open the user → **Security credentials** tab → **Access keys** → **Create access key**.
5. Choose **Application running outside AWS** (or **Command Line Interface**) → Next → Create.
6. Copy the **Access key ID** and **Secret access key** immediately (the secret is shown only once).
7. In **GitHub**: repo → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**. Add:
   - Name: `AWS_ACCESS_KEY_ID`, Value: (paste access key ID)
   - Name: `AWS_SECRET_ACCESS_KEY`, Value: (paste secret access key)

**Security:** Use a dedicated IAM user with least-privilege permissions; rotate keys periodically. Do not commit keys to the repo.

## Branch protection (recommended)

To enforce “only PR to main can provision”:

1. Repo → Settings → Branches → Add rule for `main`.
2. Enable **Require a pull request before merging** and **Require status checks to pass** (e.g. a “validate” workflow on PR).
3. Merge only via PR; the push to `main` from the merge will trigger this deploy workflow.
