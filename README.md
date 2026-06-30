# TokenCostBar

A minimal macOS menu bar app for tracking local AI agent usage costs.

TokenCostBar reads local AI agent usage logs, estimates cost, and shows today's
total in the macOS menu bar. Click the menu bar item to see recent daily trend
and per-agent totals.

The goal is to give developers a quick, low-noise view of AI agent spending
without opening dashboards or inspecting log files.

Currently supported sources:

- Claude Code: `~/.claude/projects`
- Codex: `~/.codex/sessions`

## Requirements

- macOS 14 or later
- Swift 6 / Xcode 16 or later only if you package it locally

## Install

Download a packaged build from GitHub Releases or the Package workflow
artifacts.

- Open the downloaded DMG, or unzip the `.app.zip` artifact.
- Move `TokenCostBar.app` to `/Applications`.
- Add it to Login Items in System Settings if you want it to start automatically.

After launch, TokenCostBar stays in the macOS menu bar. Click the menu bar item
to view today's cost, recent trend, and per-agent totals.

## Package

The recommended way to package is GitHub Actions:

- Open the Package workflow in GitHub Actions.
- Run the workflow on `main`.
- Download the generated artifact. It includes a DMG and `.app.zip`.

To package locally from a checkout:

```bash
scripts/package-dmg.sh
open dist/TokenCostBar-0.1.0.dmg
```
