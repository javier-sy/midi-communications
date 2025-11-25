require 'midi-communications-macos'

module MIDICommunications
  # Platform-specific adapters for MIDI communication.
  # @api private
  module Adapter
    # macOS adapter using the midi-communications-macos gem.
    #
    # Uses Core MIDI to communicate with MIDI devices on macOS.
    #
    # @api private
    module MacOS
      # Loader for macOS MIDI devices.
      # @api private
      module Loader
        extend self

        # Returns all available MIDI input sources.
        # @return [Array<MIDICommunicationsMacOS::Source>]
        def inputs
          ::MIDICommunicationsMacOS::Endpoint.all_by_type[:source]
        end

        # Returns all available MIDI output destinations.
        # @return [Array<MIDICommunicationsMacOS::Destination>]
        def outputs
          ::MIDICommunicationsMacOS::Endpoint.all_by_type[:destination]
        end
      end
    end
  end
end
