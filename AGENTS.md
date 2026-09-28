# smelt-it-dealt-it

A WoW: Forever addon that tells the player if an ore is worth more as ore or as a smelted bar.
Forever is the `_classic_beta_` client (1.60.x, Interface 16001), installed at `/Applications/World of Warcraft/_classic_beta_/`.

## Project

- **Taint**: attach UI through addon APIs and own frames; keep Blizzard frames untouched.
- **Reference code**: the installed Auctionator and Baganator sources under `Interface/AddOns/` are the ground truth for their APIs.
- **Auctionator license**: Auctionator is "All Rights Reserved". Call only `Auctionator.API.v1`, through the price-source module (ADR 0001), and write our own code for anything else. `~/workspaces/dev/CraftSim` is an open reference for the same integrations.

## Agent skills

### Issue tracker

Issues are GitHub Issues on dbspringer/smelt-it-dealt-it, driven with the `gh` CLI. See `docs/agents/issue-tracker.md`. Issues are for problems that users find. Planned work and TODOs go in the vault (see Plans and research), never in an issue. This overrides any skill that says to publish work to the issue tracker.

### Triage labels

Default vocabulary: needs-triage, needs-info, ready-for-agent, ready-for-human, wontfix. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `CONTEXT.md` and `docs/adr/` at the repo root. See `docs/agents/domain.md`.

## Plans and research

Plans, research, and other working notes live in the Obsidian vault, under `Smelt It Dealt It/`, not in this repo. This overrides any skill that says to write such a file in the repo (for example `/research`). `CONTEXT.md` and `docs/adr/` stay in the repo.

- Use the `obsidian` CLI; the app must be open. `obsidian create path="Smelt It Dealt It/<Topic> Research.md" content="..."`, and also `read`, `append`, `search`.
- Name notes `<Topic> Research.md` or `<Topic> Plan.md`, and link each new note from the index note `Smelt It Dealt It/Smelt It Dealt It.md`.
- Track TODOs and planned work in the Backlog section of the index note, with a link to the plan note when one exists.
- Read the index note before you plan work. The vault is at `~/Documents/Obsidian Vault`.

## Conventions

- Display text goes through `ns.L[...]` or a Blizzard global string, never a literal. enUS is the key, so a missing translation shows English. The first code that shows text adds the scaffold: `locales/enUS.lua`, loaded first in the TOC, sets `ns.L` to a table whose `__index` returns the key. A translation lives in `locales/<locale>.lua`, returns early unless `GetLocale()` matches, then assigns into `ns.L`.
  - Item names come from the client (`Item:CreateFromItemID`, which can load asynchronously), never from a literal. The Shopping List's Auctionator searches use the same localized name.
  - Money goes through the client's coin formatting (`GetMoneyString` / `GetCoinTextureString`), never a hand-built "1g 20s".
  - Text with values is one whole-sentence key with `format` placeholders, never text joined from pieces, since word order differs between languages.
  - Only enUS exists while the addon is built. Before release 1, one pass adds the 8 SCT Mover locales (machine translations) and a `spec/locales_spec.lua` like SCT Mover's. Each Verdict name gets one fixed translation per language.
- Text that people read (PR titles and descriptions, commit messages, issue comments, the README) goes through the `/writing-style` skill first. Code comments and the docs under `docs/` keep a neutral, technical voice. Chat replies in the CLI are out of scope.
- A release version is a plain integer that goes up by 1 for each publish (`1`, `2`, `3`), with no `v` prefix and no semver. The tag is that number, and a pushed tag starts the release workflow. Find the next number with `git tag --sort=-v:refname | head -1`. Derek decides when to tag.
- Every release gets an entry in `CHANGELOG.md`, under a `## <number>` heading, newest first. Write it for players: what changed for them, not how. A change that players can see adds its line in the same PR, under the next number; the first such change creates the file. The packager uses this file for the release notes.
- The first spec adds busted: a `.busted` file with `ROOT = { "spec" }`, and a `test.yml` workflow that runs `busted` on Lua 5.1. `../sct-mover` has both.
