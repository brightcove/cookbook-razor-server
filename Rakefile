#!/usr/bin/env rake

desc "Runs foodcritic linter"
task :foodcritic do
  if Gem::Version.new("1.9.2") <= Gem::Version.new(RUBY_VERSION.dup)
    sandbox = File.join(File.dirname(__FILE__), %w{tmp foodcritic razor_server})
    prepare_sandbox(sandbox)

    sh "foodcritic --epic-fail any #{File.dirname(sandbox)}"
  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
  end
end

desc "Runs chefspec"
task :spec do
  if Gem::Version.new("1.9.2") <= Gem::Version.new(RUBY_VERSION.dup)
    sandbox = File.join(File.dirname(__FILE__), %w{tmp spec razor_server})
    prepare_sandbox(sandbox)

    sh "rspec #{File.dirname(sandbox)}"
  else
    puts "WARN: spec run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
  end
end

task :default => ['foodcritic','spec']

private

def prepare_sandbox(sandbox)
  files = %w{*.md *.rb attributes definitions files libraries providers
recipes resources spec templates test}

  rm_rf sandbox
  mkdir_p sandbox
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox
  puts "\n\n"
end
