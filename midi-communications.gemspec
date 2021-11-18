Gem::Specification.new do |s|
  s.name        = 'midi-communications'
  s.version     = '0.5.0'
  s.date        = '2021-11-17'
  s.summary     = 'Platform independent realtime MIDI input and output for Ruby'
  s.description = 'Access MIDI devices for MacOS, Linux (wip), Windows (wip) and JRuby (wip).'
  s.authors     = ['Javier Sánchez Yeste']
  s.email       = ['javier.sy@gmail.com']
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.homepage    = 'https://rubygems.org/gems/midi-communications'
  s.license     = 'LGPL-3.0'

  s.required_ruby_version = '~> 2.7'

  # TODO
  #s.metadata    = {
  # "source_code_uri" => "https://",
  # "homepage_uri" => "",
  # "documentation_uri" => "",
  # "changelog_uri" => ""
  #}

  s.add_runtime_dependency 'midi-communications-macos', '~> 0.5', '>= 0.5.0'
  # s.add_runtime_dependency  'alsa-rawmidi', '~> 0.3', '>= 0.3.1'
  # s.add_runtime_dependency  'midi-jruby', '~> 0.1', '>= 0.1.4'
  # s.add_runtime_dependency  'midi-winmm', '~> 0.1', '>= 0.1.10'

  s.add_development_dependency 'minitest', '~> 5.14', '>= 5.14.4'
  s.add_development_dependency 'rake', '~> 13.0', '>= 13.0.6'
  s.add_development_dependency 'shoulda-context', '~> 2.0', '>= 2.0.0'
end
