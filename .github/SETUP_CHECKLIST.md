# Repository Setup Checklist

## Initial Setup

### 1. Enable GitHub Actions

- [ ] Settings → Actions → General → Enable workflows
- [ ] Set "Read and write permissions"

### 2. Enable Renovate (Required)

- [ ] Create a **Classic PAT** (Settings → Developer settings → Personal access tokens → Tokens (classic))
  - Scopes: `repo` (full control) + `workflow` (update workflows)
- [ ] Add the token as repository secret **`RENOVATE_TOKEN`** (Settings → Secrets and variables → Actions)
- [ ] Enable **Settings → General → Pull Requests → Allow auto-merge**
- [ ] Configure branch protection for `main`:
  - Settings → Branches → Add rule
  - Set **Branch name pattern** to `main`
  - Enable "Require a pull request before merging"
  - Enable "Require status checks to pass before merging"
  - Add `validate` as a required status check
  - Enable "Require branches to be up to date before merging"
- [ ] Renovate will create a PR to pin your GitHub Actions to SHAs
