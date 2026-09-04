class Detour < Formula
  desc "Terminal-first HTTP debugging proxy with a real-time web dashboard"
  homepage "https://github.com/rwadada/Detour"
  # Detour's source repo is private (issue #52), so its GitHub Release
  # asset download needs an Authorization header — set
  # HOMEBREW_GITHUB_API_TOKEN (a GitHub token with `repo` scope) before
  # `brew install`, e.g. in your shell profile:
  #   export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
  # CurlDownloadStrategy (the default; no `using:` needed) automatically
  # drops this header after the redirect to
  # objects.githubusercontent.com, so it's safe to always send it here.
  url "https://github.com/rwadada/Detour/releases/download/v0.1.10/detour-0.1.10.tar.gz",
      header: "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"
  sha256 "a60d185f78d6caeac54276c7f23652875ad3097fcdd88802d9506833907b1f17"
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
