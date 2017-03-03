require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet/version'
require 'puppet/vendor/semantic/lib/semantic' unless Puppet.version.to_f < 3.6
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
# patched for new rh version, find out if this needed for testing
# require 'ci/reporter/rake/rspec'

ENV['STRICT_VARIABLES'] = 'no'

# These gems aren't always present, for instance
# on Travis with --without development
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

PuppetLint.configuration.relative = true
PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
PuppetLint.configuration.fail_on_warnings = true

# Forsake support for Puppet 2.6.2 for the benefit of cleaner code.
# http://puppet-lint.com/checks/class_parameter_defaults/
PuppetLint.configuration.send('disable_class_parameter_defaults')
# http://puppet-lint.com/checks/class_inherits_from_params_class/
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
# Module name does not match class name
PuppetLint.configuration.send('disable_autoloader_layout')
PuppetLint.configuration.send('disable_inherits_across_namespaces')

exclude_paths = [
  "bundle/**/*",
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths

desc "Run acceptance tests"
RSpec::Core::RakeTask.new(:acceptance) do |t|
  t.pattern = 'spec/acceptance'
end

desc "Populate CONTRIBUTORS file"
task :contributors do
  system("git log --format='%aN' | sort -u > CONTRIBUTORS")
end

# task :metadata do
#  sh "metadata-json-lint metadata.json"
# end

task :setbeaker_env do
  system("BEAKER=true rake beaker")
end

desc "Run spec using ci_reporter. Run as: bundle exec rake ci:all"
namespace :ci do
  task :all => ['ci:setup:rspec', 'spec']
end

desc "Run beaker using rspec .fixtures.yml."
task :beaker_fixtures => [
  :spec_clean,
  :spec_prep,
  :setbeaker_env,
]

desc "Run syntax, lint, and spec tests."
task :test => [
  :syntax,
  :lint,
  :spec,
#  :metadata,
]
