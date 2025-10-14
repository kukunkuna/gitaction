## Quick orientation

This repo is a small Terraform project whose CI is driven by GitHub Actions. Key integration points:
- Terraform CLI managed via `hashicorp/setup-terraform` in `.github/workflows/Terraform.yml`.
- Terraform Cloud remote backend configured in `provider.tf` (organization: `GUBIHOME`, workspace: `gitauction`).
- AWS provider configured in `provider.tf` with region `us-east-1` and provider constraint `~> 6.0`.

## Primary developer workflows (discoverable in the repo)
- CI (GitHub Actions): `.github/workflows/Terraform.yml` runs the sequence: `terraform init`, `terraform fmt -check`, `terraform plan -input=false`, and on main branch push `terraform apply -auto-approve -input=false`.
  - Note: the workflow uses `cli_config_credentials_token: ${{ secrets.TF_DEMO_API_TOKEN }}` to authenticate to Terraform Cloud. The README text in the workflow references `TF_API_TOKEN` — this is a discovered inconsistency; prefer the currently used secret name `TF_DEMO_API_TOKEN` unless instructed otherwise.
- Local quick checks you can run (explicit commands seen in CI):
  - `terraform init`
  - `terraform fmt -check`
  - `terraform plan -input=false`
  - `terraform apply -auto-approve -input=false` (use only when you intend to change infra)

## Files and patterns to know
- `provider.tf` — central Terraform settings: required provider (aws), AWS region, and Terraform Cloud backend config (organization/workspace). Edit this to change cloud/workspace/provider settings.
- `.github/workflows/Terraform.yml` — the authoritative CI workflow. It sets `defaults.run.shell: bash` and installs Terraform via `hashicorp/setup-terraform@v1`.
- `.github/workflows/Application.yml` — contains a minimal example job useful as a template for additional CI jobs.

## Conventions & gotchas (explicitly observable)
- Terraform state is stored remotely in Terraform Cloud (remote backend). The `cloud` block in `provider.tf` lists `organization = "GUBIHOME"` and `workspaces { name = "gitauction" }`.
- The workflow uses a GitHub secret to configure `hashicorp/setup-terraform`. The token variable name in the workflow is `TF_DEMO_API_TOKEN`. If you change the secret name, update the workflow.
- The `apply` step in the workflow contains an `if` guard: `if: github.ref == 'refs/heads/"main"' && github.event_name == 'push'` — note the extra quotes around `main`. Treat this as suspicious; confirm intent with the repo owner before fixing in a PR.

## What an AI coding agent should do first
- Read `provider.tf` and `.github/workflows/Terraform.yml` to understand cloud target, secret names, and CI flow.
- Avoid making silent changes to secrets, workspace names, or the `apply` guard. Instead: draft a PR describing the change and include the rationale.
- When suggesting changes to CI (for example, renaming `TF_DEMO_API_TOKEN` to `TF_API_TOKEN`), include a migration note instructing maintainers to add/update the GitHub secret.

## Helpful, concrete examples to reference in edits
- To update the Terraform token usage in CI (example):
  - Current: `cli_config_credentials_token: ${{ secrets.TF_DEMO_API_TOKEN }}`
  - If you propose `TF_API_TOKEN`, include a note: `Please update repository secret TF_API_TOKEN to your Terraform Cloud token.`
- To run the same checks locally (mirror CI):
  - `terraform init && terraform fmt -check && terraform plan -input=false`

## Edge cases & checks to perform before changing infra
- Confirm that `main.tf` or other resource files exist before running `apply` (the repo currently has only `provider.tf`).
- Confirm GitHub secret exists: `TF_DEMO_API_TOKEN` (or the name you intend to use).
- If workspace/org names change, verify Terraform Cloud workspace exists and you have proper permissions.

## When to ask the human owner
- Any change that touches secrets, the Terraform Cloud organization/workspace (`GUBIHOME` / `gitauction`), or the `apply` guard condition.
- If you plan to change the `runs-on` or runner OS for CI (some Terraform commands or providers may behave differently on non-linux runners).

## Files to cite when making PRs
- `provider.tf` for backend/provider changes
- `.github/workflows/Terraform.yml` for CI changes
- `.github/workflows/Application.yml` for job templates

If anything here is incomplete or you want the instructions tailored (for example: adding local debugging commands, or standard PR templates), tell me which areas to expand and I'll iterate.