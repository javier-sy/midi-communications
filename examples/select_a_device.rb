#!/usr/bin/env ruby

$LOAD_PATH.prepend(File.expand_path('../lib', __dir__))

require 'midi-communications'

#
# This is an example that explains how to select an output.
# It's not really meant to be run.
#

# Prompt the user for selection in the console

output = MIDICommunications::Output.gets

# The user will see a list that reflects their local MIDI configuration, and be prompted to select a number

# Select a MIDI output
# 1) IAC Device
# 2) Roland UM-2 (1)
# 3) Roland UM-2 (2)
# >

# Once they've selected, the device that corresponds with their selection is returned.

# (Note that it's returned open so you don't need to call output.open)

# Hard-code the selection like this

output = MIDICommunications::Output.use(:first)
output = MIDICommunications::Output.use(0)

# or

output = MIDICommunications::Output.open(:first)
output = MIDICommunications::Output.open(0)

# If you want to wait to open the device, you can select it with any of these "finder" methods

output = MIDICommunications::Output.first
output = MIDICommunications::Output[0]
output = MIDICommunications::Output.all[0]
output = MIDICommunications::Output.all.first
output = MIDICommunications::Device.all_by_type(:output)[0]
output = MIDICommunications::Device.all_by_type(:output).first

# You'll need to call open on these before you use it or an exception will be raised

output.open

# It's also possible to select a device by name

output = MIDICommunications::Output.find_by_name('Roland UM-2 (1)').open

# or using regex match

output = MIDICommunications::Output.find { |device| device.name.match(/Launchpad/) }.open(:first)
