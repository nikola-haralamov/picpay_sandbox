# frozen_string_literal: true

require_relative "lib/picpay_sandbox/version"

Gem::Specification.new do |spec|

  spec.name    = 'picpay_sandbox'
  spec.version = PicPaySandbox::VERSION
  spec.authors = ['Latam Gateway']
  spec.email   = %w[nikola.haralamov@elando.com nikola.haralamov@latamgateway.com]

  spec.summary               = 'PicPay REST API Sandbox Server'
  spec.description           = 'PicPay sandbox API using RODA server.'
  spec.homepage              = 'https://github.com/nikola-haralamov/picpay_sandbox'
  spec.required_ruby_version = '>= 3.2.2'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri']   = spec.homepage + '/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
