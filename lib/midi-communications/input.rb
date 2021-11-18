require 'midi-communications/input/stream_reader'

module MIDICommunications
  # A MIDI input device
  class Input
    extend Device::ClassMethods
    include Device::InstanceMethods
    include StreamReader

    # All MIDI input devices -- used to populate the class
    # @return [Array<Input>]
    def self.all
      Loader.devices(direction: :input)
    end
  end
end
