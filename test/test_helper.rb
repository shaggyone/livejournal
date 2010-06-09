lib_dir = File.join(File.dirname(__FILE__), *%w[.. lib])

require 'test/unit'
require 'fileutils'
$:.unshift lib_dir unless $:.include?(lib_dir)
require 'livejournal'
