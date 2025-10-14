Sentinel policy: restrict EC2 instance types

This repository includes a Sentinel policy that enforces EC2 instances use only `t2.micro`.

Files:
- `restrict_instance_type.sentinel` — Sentinel rule that inspects plan resource changes and allows creations/updates only when `instance_type` is `t2.micro` (deletions are allowed).

How to use:
1. In Terraform Cloud, create or update a Policy Set and include this policy file.
2. Attach the Policy Set to the workspace that manages this repository (workspace: `gitauction`).
3. Run a plan in Terraform Cloud; the policy will evaluate the plan and block plans that create or update `aws_instance` resources with any `instance_type` other than `t2.micro`.

Notes:
- This policy checks resources of type `aws_instance`. If your project uses other modules that create instances under different resource types or via modules with different addresses, adjust the policy accordingly.
- Sentinel policies run in Terraform Cloud (or Enterprise). Local `terraform plan` won't evaluate Sentinel policies unless you run them via the Sentinel CLI and provide the plan file.
