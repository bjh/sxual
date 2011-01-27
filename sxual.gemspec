# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sxual/version"

Gem::Specification.new do |s|
  s.name        = "sxual"
  s.version     = Sxual::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["this guy and that guy"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{Generate Rails schemas or Migrations from SQLEditor .sqs files.}
  s.description = %q{Generate Rails schemas or Migrations from SQLEditor .sqs files.}

  s.rubyforge_project = "sxual"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
