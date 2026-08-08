class Taskforce < Formula
  desc "Taskforce dashboard and MCP CLI"
  homepage "https://github.com/taskforcehq/taskforce"
  url "https://registry.npmjs.org/@taskforcehq/taskforce/-/taskforce-0.3.328.tgz"
  sha256 "df0e9455f6d1a4c03a40ef882121d40d8b3ade1fde9ee6b9aacd5ff960e16d81"
  license :cannot_represent

  depends_on "node@22"
  depends_on "python@3.13" => :build

  def install
    system "npm", "install", *std_npm_args
    cd libexec/"lib/node_modules/@taskforcehq/taskforce" do
      ENV["PYTHON"] = (Formula["python@3.13"].opt_bin/"python3.13").to_s
      system "npm", "rebuild", "better-sqlite3", "--build-from-source"
    end
    (bin/"taskforce").write_env_script libexec/"bin/taskforce",
      PATH: "#{Formula["node@22"].opt_bin}:$PATH"
  end

  test do
    assert_match "Taskforce CLI", shell_output("#{bin}/taskforce help")
    cd libexec/"lib/node_modules/@taskforcehq/taskforce" do
      system Formula["node@22"].opt_bin/"node", "-e",
        "const Database = require('better-sqlite3'); new Database(':memory:').close();"
    end
  end
end
