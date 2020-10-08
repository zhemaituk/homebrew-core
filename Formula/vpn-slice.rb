class VpnSlice < Formula
  include Language::Python::Virtualenv

  desc "Vpnc-script replacement for easy and secure split-tunnel VPN setup"
  homepage "https://github.com/dlenski/vpn-slice"
  url "https://github.com/dlenski/vpn-slice/archive/v0.14.2.tar.gz"
  sha256 "cae69cfe2994fea487f563edb601f7ef8a59b5059baa104349121764da9d37a2"
  license "GPL-3.0"
  revision 1
  head "https://github.com/dlenski/vpn-slice.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "913cade2832a94bdd301ec1607bb9536abebcab70ec89fbb07d8226d580b93bd" => :catalina
    sha256 "25853a55dbd7b31f1724297c5d1a249fc4e40e9da268052e01fcda985346f5bd" => :mojave
    sha256 "e306dcb3032b7e14abd6f0d22392e365248816b4a345b14b020d7fd608a52fb3" => :high_sierra
  end

  depends_on "python@3.9"

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/ec/c5/14bcd63cb6d06092a004793399ec395405edf97c2301dfdc146dfbd5beed/dnspython-1.16.0.zip"
    sha256 "36c5e8e38d4369a08b6780b7f27d790a292b2b08eea01607865bf0936c558e01"
  end

  resource "setproctitle" do
    url "https://files.pythonhosted.org/packages/5a/0d/dc0d2234aacba6cf1a729964383e3452c52096dc695581248b548786f2b3/setproctitle-1.1.10.tar.gz"
    sha256 "6283b7a58477dd8478fbb9e76defb37968ee4ba47b05ec1c053cb39638bd7398"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # vpn-slice needs root/sudo credentials
    output = `#{bin}/vpn-slice 192.168.0.0/24 2>&1`
    assert_match "Cannot read\/write \/etc\/hosts", output
    assert_equal 1, $CHILD_STATUS.exitstatus
  end
end
