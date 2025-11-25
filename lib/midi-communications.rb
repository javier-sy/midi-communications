#
# MIDI Communications
# Platform independent realtime MIDI IO for Ruby
#
# (c)2021 Javier Sánchez Yeste for the modifications, licensed under LGPL 3.0 License
# (c)2011-2017 Ari Russo
#

# modules
require 'midi-communications/device'
require 'midi-communications/platform'
require 'midi-communications/type_conversion'

# classes
require 'midi-communications/input'
require 'midi-communications/loader'
require 'midi-communications/output'

require_relative 'midi-communications/version'

# Platform-independent realtime MIDI input and output for Ruby.
#
# MIDICommunications provides a unified API for MIDI communication across
# different platforms (macOS, Linux, Windows, JRuby). It automatically
# detects the current platform and loads the appropriate low-level adapter.
#
# This library is part of the MusaDSL MIDI suite:
# - {https://github.com/javier-sy/midi-events MIDI Events} - MIDI message representation
# - {https://github.com/javier-sy/midi-parser MIDI Parser} - MIDI data parsing
# - {https://github.com/javier-sy/midi-communications MIDI Communications} - MIDI I/O (this library)
# - {https://github.com/javier-sy/midi-communications-macos MIDI Communications MacOS} - macOS adapter
#
# @example List all MIDI outputs
#   MIDICommunications::Output.list
#   # 0) IAC Driver Bus 1
#   # 1) USB MIDI Device
#
# @example Send a note to the first output
#   output = MIDICommunications::Output.first
#   output.puts(0x90, 60, 100)  # Note On, middle C, velocity 100
#   sleep(0.5)
#   output.puts(0x80, 60, 0)    # Note Off
#
# @example Receive MIDI from an input
#   input = MIDICommunications::Input.first
#   loop do
#     messages = input.gets
#     messages.each { |m| puts m.inspect }
#   end
#
# @example Interactive device selection
#   output = MIDICommunications::Output.gets  # Prompts user to select
#   input = MIDICommunications::Input.gets
#
# @see Input MIDI input device class
# @see Output MIDI output device class
#
# @api public
module MIDICommunications
  Platform.bootstrap
end
