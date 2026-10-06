class Hitkeep < Formula
  desc "Privacy-friendly, self-hosted web analytics"
  homepage "https://hitkeep.com"
  url "https://github.com/PascaleBeier/hitkeep/archive/refs/tags/v2.14.1.tar.gz"
  sha256 "8b7acecad0b9a81c3434971b05098695ad1e888a1ea1fd36b8621dc038cf7e7a"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    ENV["GOTOOLCHAIN"] = "auto"
    ldflags = "-X hitkeep/cmd.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:),
           "-tags", "hashicorpmetrics,timetzdata", "./cmd/hitkeep/main.go"
  end

  test do
    output = shell_output("#{bin}/hitkeep -healthcheck -http-addr=127.0.0.1:0 2>&1", 1)
    assert_match "Healthcheck failed", output
  end
end
