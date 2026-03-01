class TmuxEclbg < Formula
  # Based on Homebrew core tmux formula:
  # https://github.com/Homebrew/homebrew-core/blob/master/Formula/t/tmux.rb
  desc "Terminal multiplexer (eclbg fork)"
  homepage "https://github.com/eclbg/tmux"
  url "https://github.com/eclbg/tmux/archive/refs/tags/3.6a-eclbg.tar.gz"
  version "3.6a-eclbg"
  sha256 "847dd2159d52277e75f2c270c2e927a7bab33ea52e63825700290259977603e5"
  license "ISC"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "libevent"
  depends_on "ncurses"
  depends_on "utf8proc"

  uses_from_macos "bison" => :build

  conflicts_with "tmux", because: "both install a tmux binary"

  def install
    system "sh", "autogen.sh"
    system "./configure", "--enable-sixel", "--enable-utf8proc", "--sysconfdir=#{etc}", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tmux -V")
  end
end
