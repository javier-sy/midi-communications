$LOAD_PATH.prepend __dir__
$LOAD_PATH.prepend File.join(__dir__, 'lib')

require 'rake'
require 'rake/testtask'
require 'midi-communications'

namespace(:test) do
  task all: [:unit, :integration]

  Rake::TestTask.new(:integration) do |t|
    t.libs << 'test'
    t.test_files = FileList['test/integration/**/*_test.rb']
    t.verbose = true
  end

  Rake::TestTask.new(:unit) do |t|
    t.libs << 'test'
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = true
  end
end

Rake::Task['test'].enhance ['test:all']

platforms = ['generic', 'x86_64-darwin10.7.0', 'i386-mingw32', 'java', 'i686-linux']

task(:build) do
  require 'midi-communications-gemspec'
  platforms.each do |platform|
    MIDICommunications::Gemspec.new(platform)
    filename = "midi-communications-#{platform}.gemspec"
    system "gem build #{filename}"
    system "rm #{filename}"
  end
end

task(release: :build) do
  platforms.each do |platform|
    system "gem push midi-communications-#{MIDICommunications::VERSION}-#{platform}.gem"
  end
end

task(default: [:test])
