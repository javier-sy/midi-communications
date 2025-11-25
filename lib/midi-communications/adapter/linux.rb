require 'alsa-rawmidi'

module MIDICommunications
  module Adapter
    # Linux adapter using the alsa-rawmidi gem.
    #
    # Uses ALSA to communicate with MIDI devices on Linux.
    #
    # @api private
    module Linux
      # Loader for Linux MIDI devices.
      # @api private
      module Loader
        extend self

        # Returns all available MIDI input devices.
        # @return [Array<AlsaRawMIDI::Input>]
        def inputs
          ::AlsaRawMIDI::Device.all_by_type[:input]
        end

        # Returns all available MIDI output devices.
        # @return [Array<AlsaRawMIDI::Output>]
        def outputs
          ::AlsaRawMIDI::Device.all_by_type[:output]
        end
      end
    end
  end
end
