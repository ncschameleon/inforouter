require 'bundler/gem_tasks'
require 'rake/testtask'

gemspec = eval(File.read(Dir['*.gemspec'].first))

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/test_*.rb'
  test.verbose = false
end

desc 'Validate the gemspec.'
task :gemspec do
  puts gemspec.validate
end

require 'rubocop/rake_task'
Rubocop::RakeTask.new(:rubocop)

task :default => [:rubocop, :test]
