require "dartsass/runner"

namespace :dartsass do
  desc "Build your Dart Sass CSS"
  task build: :environment do
    system Dartsass::Runner.dartsass_compile_command, exception: true
  end

  desc "Watch and build your Dart Sass CSS on file changes"
  task watch: :environment do
    system "#{Dartsass::Runner.dartsass_compile_command} -w", exception: true
  end
end

Rake::Task["assets:precompile"].enhance(["dartsass:build"])

if Rake::Task.task_defined?("test:prepare")
  Rake::Task["test:prepare"].enhance(["dartsass:build"])
elsif Rake::Task.task_defined?("db:test:prepare")
  Rake::Task["db:test:prepare"].enhance(["dartsass:build"])
end
