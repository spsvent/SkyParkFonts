# SkyParkFonts

Shared SkyPark font assets.

## Setup, run and verification

This repository has no verified single setup/run/test procedure yet. Establish the
runbook with Justin before running tools against production. The workflow baseline
does not authorize executing a service, migration, or deployment.

Read [AGENTS.md](AGENTS.md) for preserved project context and safety constraints.

## Ownership and GitHub workflow

Owner: **Justin Nunn (`@skyparkjustin`), SkyPark IT/AV**.
Canonical repository: [spsvent/SkyParkFonts](https://github.com/spsvent/SkyParkFonts).
Default branch: `main`; work in a separate issue branch.

Read [the clone setup and PR workflow](docs/GITHUB-WORKFLOW.md) and enable the
reviewed identity guards with `sh tools/install-git-hooks.sh` (Python 3 required).
Preserve any existing hooks. Leave notes in [docs/handoffs](docs/handoffs/README.md).

This baseline does not enable server-side branch protection, rotate secrets, or
verify deployment health. Those remain tracked in spsvent/SkyPark#101.
