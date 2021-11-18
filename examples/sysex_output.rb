#!/usr/bin/env ruby

$LOAD_PATH.prepend(File.expand_path('../lib', __dir__))

require 'midi-communications'

# Prompts the user to select a MIDI output
# Sends a MIDI system exclusive message to that output
 
sysex_msg = [0xF0, 0x41, 0x10, 0x42, 0x12, 0x40, 0x00, 0x7F, 0x00, 0x41, 0xF7]

output = MIDICommunications::Output.gets

output.puts(sysex_msg)
