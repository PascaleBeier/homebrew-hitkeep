class Hitkeep < Formula
  desc "Privacy-friendly, self-hosted web analytics"
  homepage "https://hitkeep.com"
  url "https://github.com/PascaleBeier/hitkeep/archive/refs/tags/v2.13.11.tar.gz"
  sha256 "571cbdca02bd3d2731c57f9c9fdd67ee23ad7eb02b8b7f4aa8edebb5e89e28b3"
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
