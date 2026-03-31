class Strider < Formula
  include Language::Python::Virtualenv

  desc "Local-first, git-backed markdown issue tracker"
  homepage "https://github.com/New-Ark-Digital/strider"
  # url and sha256 will be set on first release
  url "https://files.pythonhosted.org/packages/PLACEHOLDER/strider-md-0.1.0.tar.gz"
  sha256 "PLACEHOLDER"
  license "MIT"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/PLACEHOLDER/click-8.1.8.tar.gz"
    sha256 "PLACEHOLDER"
  end

  def install
    virtualenv_install_with_resources
  end

  def post_upgrade
    # Reinstall resources after Homebrew Python upgrade.
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/strider", "--help"
  end
end
