require_relative 'lib/midi-communications/version'

Gem::Specification.new do |s|
  s.name        = 'midi-communications'
  s.version     = MIDICommunications::VERSION
  s.date        = '2025-08-23'
  s.summary     = 'Platform independent realtime MIDI input and output for Ruby'
  s.description = 'Access MIDI devices for MacOS, Linux (wip), Windows (wip) and JRuby (wip).'
  s.authors     = ['Javier Sánchez Yeste']
  s.email       = ['javier.sy@gmail.com']
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.homepage    = 'https://github.com/javier-sy/midi-communications'
  s.license     = 'LGPL-3.0-or-later'

  s.required_ruby_version = '>= 2.7'

  s.metadata = {
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage,
    'documentation_uri' => 'https://www.rubydoc.info/gems/midi-communications'
  }

  s.add_runtime_dependency 'midi-communications-macos', '~> 0.7'
  # s.add_runtime_dependency  'alsa-rawmidi', '~> 0.3', '>= 0.3.1'
  # s.add_runtime_dependency  'midi-jruby', '~> 0.1', '>= 0.1.4'
  # s.add_runtime_dependency  'midi-winmm', '~> 0.1', '>= 0.1.10'

  s.add_development_dependency 'minitest', '~>5', '>= 5.14.4'
  s.add_development_dependency 'rake', '~>13', '>= 13.0.6'
  s.add_development_dependency 'shoulda-context', '~>2', '>= 2.0.0'

  s.add_development_dependency 'yard', '~> 0.9'
  s.add_development_dependency 'redcarpet', '~> 3.6'
  s.add_development_dependency 'webrick', '~> 1.8'
end
