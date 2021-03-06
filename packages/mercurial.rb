require 'package'

class Mercurial < Package
  version '4.0.2'
  source_url 'https://www.mercurial-scm.org/release/mercurial-4.0.2.tar.gz'
  source_sha1 '1d7b3eeed790974277db91bd1b0f34a5d142e980'

  # what's the best route for adding a minimum version symbol as a constraint?
  depends_on "python27"

  def self.build
    # would be great to avoid even downloading the source tarball if this dependency wasn't met 
    py_ver = %x[python -V 2>&1 | awk '{ print $2 }'].strip
    abort '[!] python 2.7.13 or higher is required for tig, please run `crew upgrade python27` first.' unless py_ver > '2.7.12'
    if !%x[pip list | grep osutils].include? "osutils"
      puts "Installing osutils dependency..."
      system "sudo", "pip", "install", "osutils"
    end
    if !%x[pip list | grep docutils].include? "docutils"
      puts "Installing docutils dependency..."
      system "sudo", "pip", "install", "docutils"
    end
    system "make", "PREFIX=/usr/local", "all"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
    puts "------------------"
    puts "Installation success!"
    puts "Cleaning up dependencies only required for build..."
    system "sudo", "pip", "uninstall", "docutils"
    puts
    puts "To begin using mercurial you'll need to configure it."
    puts
    puts "Run `hg debuginstall` and address any issues that it reports."
  end
end
