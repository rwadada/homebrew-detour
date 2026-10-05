class Detour < Formula
  desc "Terminal-first HTTP debugging proxy with a real-time web dashboard"
  homepage "https://github.com/rwadada/Detour"
  url "https://github.com/rwadada/Detour/releases/download/v1.7.0/detour-1.7.0.tar.gz"
  sha256 "5cbac5c19e8b8fe8b92ae98ac61a9e717f0ad3ac82060f21c0ce90766f7677b9"
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
