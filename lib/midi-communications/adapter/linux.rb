require 'alsa-rawmidi'

module MIDICommunications
  module Adapter
    # Load underlying devices using the alsa-rawmidi gem
    module Linux
      module Loader
        extend self

        # @return [Array<Linux::Input>]
        def inputs
          ::AlsaRawMIDI::Device.all_by_type[:input]
        end

        # @return [Array<Linux::Output>]
        def outputs
          ::AlsaRawMIDI::Device.all_by_type[:output]
        end
      end
    end
  end
end
