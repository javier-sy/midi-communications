require 'midi-communications-macos'

module MIDICommunications
  module Adapter
    # Load underlying devices using the coremidi gem
    module MacOS
      module Loader
        extend self

        # @return [Array<MacOS::Source>]
        def inputs
          ::MIDICommunicationsMacOS::Endpoint.all_by_type[:source]
        end

        # @return [Array<MacOS::Destination>]
        def outputs
          ::MIDICommunicationsMacOS::Endpoint.all_by_type[:destination]
        end
      end
    end
  end
end
