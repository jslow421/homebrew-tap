class LitraCam < Formula
  desc "Turn a Logitech Litra light on and off with your Mac's camera"
  homepage "https://github.com/jslow421/camera-light-automation"
  url "https://github.com/jslow421/camera-light-automation/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "51d3a4da5c0c930168f9910a7b7de8196d23948fc88d974e5f8b15bc5a676e30"
  license :cannot_represent

  depends_on "litra"
  depends_on :macos

  def install
    system "swiftc", "-O", "src/litra-cam.swift", "-framework", "CoreMediaIO", "-o", "litra-cam"
    bin.install "litra-cam"
  end

  service do
    run [opt_bin/"litra-cam"]
    keep_alive true
    log_path var/"log/litra-cam.log"
    error_log_path var/"log/litra-cam.log"
  end

  def caveats
    <<~EOS
      Building requires the Xcode Command Line Tools (xcode-select --install).
      Start the daemon with: brew services start litra-cam
      macOS may prompt for camera access on first run; approve it.
    EOS
  end

  test do
    assert_path_exists bin/"litra-cam"
  end
end
