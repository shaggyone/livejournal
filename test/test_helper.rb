require 'rubygems'
gem 'libxml-xmlrpc'
gem 'activesupport'

lib_dir = File.join(File.dirname(__FILE__), *%w[.. lib])

require File.join(File.dirname(__FILE__), *%w[.. init])
require 'test/unit'
require 'fileutils'
$:.unshift lib_dir unless $:.include?(lib_dir)
require 'livejournal'
