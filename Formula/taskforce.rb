class Taskforce < Formula
  desc "Taskforce dashboard and MCP CLI"
  homepage "https://github.com/taskforcehq/taskforce"
  url "https://registry.npmjs.org/@taskforcehq/taskforce/-/taskforce-0.3.326.tgz"
  sha256 "8b4d1b870d70a14d230382c59fd207fa0b6ccd2ff10af3d09fc8683e805e805c"
  license :cannot_represent

  depends_on "node@22"

  def install
    system "npm", "install", *std_npm_args
    (bin/"taskforce").write_env_script libexec/"bin/taskforce",
      PATH: "#{Formula["node@22"].opt_bin}:$PATH"
  end

  test do
    assert_match "Taskforce CLI", shell_output("#{bin}/taskforce help")
  end
end
