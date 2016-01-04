# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xingAPI/version'

Gem::Specification.new do |spec|
  spec.name          = "xingAPI"
  spec.version       = XingAPI::VERSION
  spec.authors       = ["Minwoo Lee"]
  spec.email         = ["ermaker@gmail.com"]

  spec.summary       = %q{xingAPI}
  spec.homepage      = "http://github.com/ermaker/xingAPI"

  spec.files         = `git ls-files -z`.force_encoding('binary').split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.rdoc_options << '-x' << 'ext'

  spec.add_dependency "ffi"
  spec.add_dependency "dotenv"
  spec.add_dependency "multi_json"
  spec.add_dependency "rake-compiler"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
