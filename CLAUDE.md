# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal Emacs configuration. The single source of truth is `init.el` — all package setup, keybindings, hooks, and customizations live there. The `custom-set-variables` / `custom-set-faces` block at the bottom is managed by Emacs itself.

## Testing Changes

There is no build or test step. To validate a change to `init.el`:
- Reload a single expression: place point at the end and `C-x C-e`
- Reload the whole config: `M-x eval-buffer` or restart Emacs

## Key Packages and Their Roles

- **ivy / counsel / swiper** — completion framework; `C-s`/`C-r` bound to `swiper`; flx provides fuzzy matching for everything except swiper (which uses `ivy--regex-plus`)
- **elpy** — Python IDE layer; RPC uses `python3`; flymake module is explicitly removed in favor of flycheck
- **flycheck** — global syntax checking (`global-flycheck-mode`)
- **company** + **company-jedi** + **company-auctex** — autocomplete, enabled per `prog-mode`
- **auctex** — LaTeX editing; `TeX-PDF-mode` on, `TeX-parse-self` on, no master file
- **yasnippet** — global snippet expansion; custom Python snippets in `snippets/python-mode/` (keys: `doc`, `fdoc`, `cdoc`, `mdoc`, `ifname`)
- **hl-todo** — highlights TODO/FIXME/WARN/NOTE/HACK/REVIEW/DEPRECATED keywords
- **solarized-dark** — active theme
- **auto-package-update** — checks for package updates on startup; old versions deleted automatically

## Conventions

- `indent-tabs-mode` is globally off; a `before-save-hook` untabifies and strips trailing whitespace on every save
- Backups go to `~/.emacs.d/backups/`, auto-saves to `~/.emacs.d/auto-save-list/`
- Font is **Hack 13pt**; toolbar and scrollbar are disabled
- `C-z` is rebound to `undo`; `M-up`/`M-down` move the current line or region (custom `uelpy-*` functions, not elpy's)

## What is Ignored

`elpa/`, `backups/`, `auto-save-list/`, and `init.el~` are gitignored — do not commit generated package files.
