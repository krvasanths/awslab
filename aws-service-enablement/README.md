# AWS Service Enablement

This folder contains **CloudFormation templates (CFT)** for:

- **Access and permissions** – IAM roles, policies, and service-linked roles
- **Permission boundaries** (future) – Scoped boundaries for delegated deployments

## Purpose

Use these templates to enable and secure AWS services before provisioning workloads in `cft/` or `tf/`. Deploy enablement stacks once per account/OU; application stacks can then assume the defined roles and stay within the permission boundary.

## Structure

- `templates/` – CFT for IAM and permission boundaries (add as needed)
- Deploy via the repo pipeline only when changes are merged to `main`.

## Future

- Permission boundary templates will be added here when required.
