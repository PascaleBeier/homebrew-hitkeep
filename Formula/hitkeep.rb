class Hitkeep < Formula
  desc "Privacy-friendly, self-hosted web analytics"
  homepage "https://hitkeep.com"
  url "https://github.com/PascaleBeier/hitkeep/archive/refs/tags/v2.13.12.tar.gz"
  sha256 "782d6ad78216d0f886e267dd71f02efd2070f65a3cf2e61eac6f10d20d0ef8a3"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X hitkeep/cmd.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:),
           "-tags", "hashicorpmetrics,timetzdata", "./cmd/hitkeep/main.go"
  end

  test do
    output = shell_output("#{bin}/hitkeep -healthcheck -http-addr=127.0.0.1:0 2>&1", 1)
    assert_match "Healthcheck failed", output
  end
end
