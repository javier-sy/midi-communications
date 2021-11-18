#!/usr/bin/env ruby

$LOAD_PATH.prepend(File.expand_path('../lib', __dir__))

require 'midi-communications'

# Prompts the user to select a midi output
# Sends some arpeggiated chords to the output

notes = [36, 40, 43] # C E G
octaves = 5
duration = 0.1

# Prompt the user to select an output
output = MIDICommunications::Output.gets

# using their selection...
(0..((octaves-1)*12)).step(12) do |oct|
  notes.each do |note|
    output.puts(0x90, note + oct, 100) # note on
    sleep(duration) # wait
    output.puts(0x80, note + oct, 100) # note off
  end
end
