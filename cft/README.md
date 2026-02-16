# CFT – AWS Service Provisioning (CloudFormation)

This folder contains **CloudFormation templates (CFT)** for provisioning AWS services (e.g. VPC, S3, Lambda, ECS, etc.).

## Usage

- Add stack templates under `templates/`.
- Stacks are deployed by the repo **deployment pipeline** when changes are **merged to the `main` branch** (PR merge only; no deploy on feature branches).

## Structure

```
cft/
├── templates/     # Stack YAML/JSON templates
└── README.md
```

## Pipeline

The pipeline (see repo root `.github/workflows/` or `pipeline/`) detects changes under `cft/` and runs `aws cloudformation deploy` (or equivalent) for the affected stacks.
