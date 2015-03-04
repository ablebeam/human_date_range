# coding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'human_date_range/version'

Gem::Specification.new do |spec|
  spec.name          = "human_date_range"
  spec.version       = HumanDateRange::VERSION
  spec.authors       = ["ablebeam"]
  spec.email         = ["victor@ablebeam.com"]
  spec.summary       = %q{Парсер человеческих дат и диапазонов для русского языка.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/ablebeam/human_date_range"
  spec.license       = "MIT"

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  spec.test_files = Dir['spec/**/*']

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "unicode", "~> 0"

  spec.add_development_dependency "rspec", "~> 3.0"
end
