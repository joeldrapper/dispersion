# frozen_string_literal: true

require_relative "lib/dispersion/version"

Gem::Specification.new do |spec|
  spec.name = "dispersion"
  spec.version = Dispersion::VERSION
  spec.authors = ["Joel Drapper"]
  spec.email = ["joel@drapper.me"]

  spec.summary = "Syntac Highlighter for Ruby"
  spec.homepage = "https://github.com/joeldrapper/dispersion"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage
  spec.metadata["funding_uri"] = "https://github.com/sponsors/joeldrapper"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end

  spec.require_paths = ["lib"]
  spec.add_dependency "prism", "~> 0.18"
end
