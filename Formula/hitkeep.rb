class Hitkeep < Formula
  desc "Privacy-friendly, self-hosted web analytics"
  homepage "https://hitkeep.com"
  url "https://github.com/PascaleBeier/hitkeep/archive/refs/tags/v2.13.18.tar.gz"
  sha256 "f9b2c7c014091a83a2dcb09de9eb9646966ace6724e1ba57f5c9e003988eeb97"
  license "MIT"

  depends_on "go" => :build

  def install
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
