#!/usr/bin/env ruby

$LOAD_PATH.prepend(File.expand_path('../lib', __dir__))

require 'midi-communications'

# Prompts the user to select a midi input
# Sends an inspection of the first 10 messages messages that input receives to standard out

num_messages = 10

# Prompt the user
input = MIDICommunications::Input.gets

# using their selection...

puts 'send some MIDI to your input now...'

num_messages.times do
  m = input.gets
  puts(m)
end

puts 'finished'
