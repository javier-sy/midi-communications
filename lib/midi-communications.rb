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

module MIDICommunications
  VERSION = '0.5.1'.freeze
  Platform.bootstrap
end
