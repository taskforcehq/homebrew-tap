class Taskforce < Formula
  desc "Taskforce dashboard and MCP CLI"
  homepage "https://github.com/Stratnexus/taskforce"
  url "https://registry.npmjs.org/@taskforcehq/taskforce/-/taskforce-0.3.168.tgz"
  sha256 "853128ac948ec8a51d42c95faecc85907455274d7d9e2f094baf1ac3c34d2f46"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/taskforce"
  end

  test do
    assert_match "Taskforce CLI", shell_output("#{bin}/taskforce help")
  end
end
