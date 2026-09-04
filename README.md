# homebrew-detour

Homebrew tap for [Detour](https://github.com/rwadada/Detour) — a terminal-first, lightweight HTTP debugging proxy for mobile and web, with a real-time web dashboard.

## Install

Detour's source repo is private, so its GitHub Release assets need an authenticated download. Set `HOMEBREW_GITHUB_API_TOKEN` to a GitHub token with `repo` scope before tapping/installing — e.g. in your shell profile:

```bash
export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
```

Then:

```bash
brew install rwadada/detour/detour
detour start --port 8080
```

## Updating the formula

After cutting a new release in the main repo (push a `vX.Y.Z` tag — `.github/workflows/release.yml` builds and publishes the tarball), bump `Formula/detour.rb`'s `url` and `sha256` to match. The release's GitHub Release notes include the tarball's sha256.
