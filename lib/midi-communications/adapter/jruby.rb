require 'midi-jruby'

module MIDICommunications
  module Adapter
    # Load underlying devices using the midi-jruby gem
    module JRuby
      module Loader
        extend self

        # @return [Array<JRuby::Input>]
        def inputs
          ::MIDIJRuby::Device.all_by_type[:input]
        end

        # @return [Array<JRuby::Output>]
        def outputs
          ::MIDIJRuby::Device.all_by_type[:output]
        end
      end
    end
  end
end
