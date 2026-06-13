# weirdo-adam Homebrew Tap

Homebrew tap for installing release packages from weirdo-adam open-source projects.

This repository provides formulae for command-line tools and applications distributed through Homebrew.

## Usage

Install a formula directly:

```sh
brew install weirdo-adam/tap/issue-jumper
brew install weirdo-adam/tap/redmine-mcp-server
```

Then install the Zed task/keymap integration when needed:

```sh
issue-jumper install-zed --force
```

Or add the tap first:

```sh
brew tap weirdo-adam/tap
brew install issue-jumper
```

## Formulae

| Formula | Description |
| --- | --- |
| `issue-jumper` | Open issue references from Zed in the corresponding tracker page. |
| `redmine-mcp-server` | Standalone stdio MCP server for Redmine. |

## Updates

```sh
brew update
brew upgrade issue-jumper redmine-mcp-server
```

## Bottles

Formulae in this tap should publish bottles through the `Bottle` GitHub Actions workflow. Normal `brew install` uses the matching bottle when available, so users do not need Rust or LLVM build dependencies for the default install path.

Use source builds only for formula development:

```sh
brew install --build-from-source weirdo-adam/tap/issue-jumper
brew install --build-from-source weirdo-adam/tap/redmine-mcp-server
```
