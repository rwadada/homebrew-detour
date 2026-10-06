class Detour < Formula
  desc "Terminal-first HTTP debugging proxy with a real-time web dashboard"
  homepage "https://github.com/rwadada/Detour"
  url "https://github.com/rwadada/Detour/releases/download/v2.0.1/detour-2.0.1.tar.gz"
  sha256 "4f9a19fb97dc91bb0125196a7149632bc257adace00c32f76a7c503894949ac0"
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
