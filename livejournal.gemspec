Gem::Specification.new do |s|
  s.name = "livejournal"
  s.version = "0.1"
  s.authors = ["Victor Zagorski"]
  s.email = "vzagorski@inbox.ru
  s.homepage = "http://github.com/shaggyone/livejournal"
  s.summary = "Livejournal allows you to post, update, delete records from livejournal. Using their XMLRPC API, of course. API can be found at: http://www.livejournal.com/doc/server/ljp.csp.xml-rpc.protocol.html"
  s.description = "Same as summary."

  s.files = Dir["lib/**/*", "[A-Z]*", "init.rb", "install.rb", "livejournal.gemspec"]
  s.test_files = Dir["test/**/*"]
  s.require_path = "lib"

  s.extra_rdoc_files = Dir["*.rdoc"]
  s.rdoc_options = ["--charset=UTF-8", "--exclude=lib/tiny_mce/assets"]

  s.required_rubygems_version = ">= 1.3.4"
# s.autorequire = "treetop" this line was taken from another gem
  s.has_rdoc = false
  s.add_dependency "libxml-xmlrpc", ">= 0.1.5"
end
