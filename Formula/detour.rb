class Detour < Formula
  desc "Terminal-first HTTP debugging proxy with a real-time web dashboard"
  homepage "https://github.com/rwadada/Detour"
  # Detour's source repo is private (issue #52). The friendly
  # github.com/OWNER/REPO/releases/download/... URL 404s for private-repo
  # assets no matter what Authorization header is sent (verified directly
  # with curl) — the actual authenticated download path is the REST API's
  # asset endpoint, which needs Accept: application/octet-stream to return
  # the binary instead of asset metadata JSON. Set HOMEBREW_GITHUB_API_TOKEN
  # (a GitHub token with `repo` scope) before `brew install`, e.g.:
  #   export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
  url "https://api.github.com/repos/rwadada/Detour/releases/assets/546268428",
      headers: [
        "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
        "Accept: application/octet-stream",
      ]
  version "0.1.13"
  sha256 "02f0466ac88d3a7a77ffb114787f830bcc3e2fd2aef288faf929357e2817727d"
  license "MIT"

  depends_on "node"

  # The release tarball (see scripts/build-release.mjs in the main repo) is
  # a single esbuild-bundled CLI file plus the built dashboard SPA — no
  # node_modules, no per-dependency `resource` stanzas needed here. Install
  # the whole thing into libexec and symlink the entry point into bin, so
  # it can still find its sibling `web-dist/` via `__dirname` regardless of
  # where Homebrew's Cellar happens to place it.
  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"detour"
  end

  test do
    assert_match "Usage: detour", shell_output("#{bin}/detour --help")
  end
end
