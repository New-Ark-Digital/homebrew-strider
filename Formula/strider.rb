class Strider < Formula
  include Language::Python::Virtualenv

  desc "Local-first, git-backed markdown issue tracker"
  homepage "https://github.com/New-Ark-Digital/strider"
  # url and sha256 are updated automatically by release.yml after each PyPI publish.
  url "https://files.pythonhosted.org/packages/source/s/strider-md/strider_md-0.1.0.tar.gz"
  sha256 "PLACEHOLDER_UPDATED_BY_RELEASE_WORKFLOW"
  license "MIT"
  head "https://github.com/New-Ark-Digital/strider.git", branch: "main"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/source/c/click/click-8.1.8.tar.gz"
    sha256 "ed53c9d8821d0d21e1711f490214d0f3e5128ff0ca6ef6f5dcba0e1b53e45a56"
  end

  def install
    virtualenv_install_with_resources
  end

  def post_upgrade
    # Reinstall virtualenv resources after a Homebrew Python upgrade.
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/strider", "--help"
    # Verify init works in a temp git repo.
    (testpath / "repo").mkpath
    system "git", "-C", "#{testpath}/repo", "init", "-b", "main"
    system "git", "-C", "#{testpath}/repo", "config", "user.email", "t@t.com"
    system "git", "-C", "#{testpath}/repo", "config", "user.name", "Test"
    system "#{bin}/strider", "init", "--board", "engineering", "--repo", "#{testpath}/repo"
    assert_predicate testpath / "repo/backlog/.strider.toml", :exist?
  end
end
