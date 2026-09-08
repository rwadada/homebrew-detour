class Detour < Formula
  desc "Terminal-first HTTP debugging proxy with a real-time web dashboard"
  homepage "https://github.com/rwadada/Detour"
  # Once the source repo is public, this friendly releases/download URL
  # serves the asset directly, no auth needed. Before that it 404s no
  # matter what Authorization header is sent — while the repo is private,
  # this formula only works from a checkout with the repo's own
  # authenticated download path substituted back in (see git history).
  url "https://github.com/rwadada/Detour/releases/download/v0.1.13/detour-0.1.13.tar.gz"
  sha256 "02f0466ac88d3a7a77ffb114787f830bcc3e2fd2aef288faf929357e2817727d"
  license "Apache-2.0"

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
