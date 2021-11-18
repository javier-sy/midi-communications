require 'midi-winmm'

module MIDICommunications
  module Adapter
    # Load underlying devices using the midi-winmm gem
    module Windows
      module Loader

        extend self

        # @return [Array<Windows::Input>]
        def inputs
          ::MIDIWinMM::Device.all_by_type[:input]
        end

        # @return [Array<Windows::Output>]
        def outputs
          ::MIDIWinMM::Device.all_by_type[:output]
        end
      end
    end
  end
end
