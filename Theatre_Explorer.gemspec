# frozen_string_literal: true

require_relative "lib/Theatre_Explorer/version"

Gem::Specification.new do |spec|
  spec.name          = "Theatre_Explorer"
  spec.version       = TheatreExplorer::VERSION
  spec.authors       = ["Drew Keat"]
  spec.email         = ["drewjkeat@gmail.com"]

  spec.summary       = "Theatre_Explorer uses a command line interface to reference information from the website broadwayworld.com."
  spec.description   = "Theatre Explorer provides a CLI for users to interact with production information from the website www.broadwayworld.com.  The user experience begins with selecting whether to search for productions by name or by year.  After that selection, specific aspects of a chosen production can be viewed in greater detail."
  spec.homepage      = "https://github.com/drewkeat/Theatre_Explorer"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["Explore!"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "mechanize", "~> 2.8"
  spec.add_development_dependency "pry", "~> 0.14.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
