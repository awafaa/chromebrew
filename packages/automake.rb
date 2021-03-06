require 'package'

class Automake < Package
  version '1.15'
  source_url 'ftp://ftp.gnu.org/gnu/automake/automake-1.15.tar.xz'
  source_sha1 'c279b35ca6c410809dac8ade143b805fb48b7655'

  depends_on 'autoconf'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
