# frozen_string_literal: true

require_relative "lib/git_modified_lines/version"

Gem::Specification.new do |spec|
  spec.name          = "git_modified_lines"
  spec.version       = GitModifiedLines::VERSION
  spec.authors       = ["Bogdan Guban"]
  spec.email         = ["biguban@gmail.com"]

  spec.summary       = "Retrieves modified lines using git diff"
  spec.description   = "Retrieves modified lines using git diff"
  spec.homepage      = "https://github.com/bguban/git_modified_lines"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bguban/git_modified_lines"
  spec.metadata["changelog_uri"] = "https://github.com/bguban/git_modified_lines/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
