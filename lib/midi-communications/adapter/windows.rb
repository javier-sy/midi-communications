require 'midi-winmm'

module MIDICommunications
  module Adapter
    # Windows adapter using the midi-winmm gem.
    #
    # Uses Windows Multimedia API to communicate with MIDI devices.
    #
    # @api private
    module Windows
      # Loader for Windows MIDI devices.
      # @api private
      module Loader
        extend self

        # Returns all available MIDI input devices.
        # @return [Array<MIDIWinMM::Input>]
        def inputs
          ::MIDIWinMM::Device.all_by_type[:input]
        end

        # Returns all available MIDI output devices.
        # @return [Array<MIDIWinMM::Output>]
        def outputs
          ::MIDIWinMM::Device.all_by_type[:output]
        end
      end
    end
  end
end
