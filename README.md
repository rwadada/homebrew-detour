# homebrew-detour

Homebrew tap for [Detour](https://github.com/rwadada/Detour) — a terminal-first, lightweight HTTP debugging proxy for mobile and web, with a real-time web dashboard.

## Install

```bash
brew install rwadada/detour/detour
detour start --port 8080
```

## Updating the formula

After cutting a new release in the main repo (push a `vX.Y.Z` tag — `.github/workflows/release.yml` builds and publishes the tarball), bump `Formula/detour.rb`'s `url` and `sha256` to match. The release's GitHub Release notes include the tarball's sha256.
