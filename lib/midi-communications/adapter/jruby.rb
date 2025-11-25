require 'midi-jruby'

module MIDICommunications
  module Adapter
    # JRuby adapter using the midi-jruby gem.
    #
    # Uses Java MIDI API to communicate with MIDI devices on JRuby.
    #
    # @api private
    module JRuby
      # Loader for JRuby MIDI devices.
      # @api private
      module Loader
        extend self

        # Returns all available MIDI input devices.
        # @return [Array<MIDIJRuby::Input>]
        def inputs
          ::MIDIJRuby::Device.all_by_type[:input]
        end

        # Returns all available MIDI output devices.
        # @return [Array<MIDIJRuby::Output>]
        def outputs
          ::MIDIJRuby::Device.all_by_type[:output]
        end
      end
    end
  end
end
