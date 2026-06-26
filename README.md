# weirdo-adam Homebrew Tap

Homebrew tap for installing release packages from weirdo-adam open-source projects.

This repository provides formulae for command-line tools and applications distributed through Homebrew.

## Usage

Install a formula or cask directly:

```sh
brew install weirdo-adam/tap/issue-jumper
brew install weirdo-adam/tap/redmine-mcp-server
brew install --cask weirdo-adam/tap/repopeek
```

Then install the Zed task/keymap integration when needed:

```sh
issue-jumper install-zed --force
```

If `issue-jumper` is not found in a new shell, add Homebrew to `PATH` with `brew shellenv`, or use the full Homebrew path:

```sh
/opt/homebrew/bin/issue-jumper install-zed --force
```

If a previous one-command install exists at `~/.local/bin/issue-jumper`, it can shadow the Homebrew version. Remove that manual copy with:

```sh
curl -fsSL https://raw.githubusercontent.com/weirdo-adam/issue-jumper/main/scripts/install.sh | sh -s -- --uninstall
```

Or add the tap first:

```sh
brew tap weirdo-adam/tap
brew install issue-jumper
```

## Formulae & Casks

| Name | Type | Description |
| --- | --- | --- |
| `issue-jumper` | Formula | Open issue references from Zed in the corresponding tracker page. |
| `redmine-mcp-server` | Formula | Standalone stdio MCP server for Redmine. |
| `repopeek` | Cask | GitLab repository status in the macOS menu bar. |

## Updates

```sh
brew update
brew upgrade issue-jumper redmine-mcp-server
brew upgrade --cask repopeek
```

## Bottles

Formulae in this tap should publish bottles through the `Bottle` GitHub Actions workflow. Normal `brew install` uses the matching bottle when available, so users do not need Rust or LLVM build dependencies for the default install path.

Use source builds only for formula development:

```sh
brew install --build-from-source weirdo-adam/tap/issue-jumper
brew install --build-from-source weirdo-adam/tap/redmine-mcp-server
```
