class LitraCam < Formula
  desc "Turn a Logitech Litra light on and off with your Mac's camera"
  homepage "https://github.com/jslow421/camera-light-automation"
  url "https://github.com/jslow421/camera-light-automation/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "9b76c80a8d2d68b2dbb407409f6418114ac4c45256af139445d86522c8f6dc16"
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
