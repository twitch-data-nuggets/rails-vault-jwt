# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$:.unshift(lib) unless $:.include?(lib)
require 'rails/vault/jwt/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails-vault-jwt'
  spec.version       = Rails::Vault::JWT::VERSION
  spec.authors       = ['Nick King']
  spec.email         = ['penguin@frozendesert.net']

  spec.summary       = 'Provides rails concerns for validating vault-issued JWT tokens'
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/datanuggets/rails-vault-jwt'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/datanuggets/rails-vault-jwt'
    spec.metadata['changelog_uri'] = 'https://github.com/datanuggets/rails-vault-jwt/blob/main/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 6.1'
  spec.add_dependency 'jwt', '~> 2.2'
  spec.add_dependency 'vault', '~> 0.15'
  spec.add_development_dependency 'actionpack', '~> 6.1'
  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
