require 'midi-communications/input/stream_reader'

module MIDICommunications
  # A MIDI input device for receiving MIDI messages.
  #
  # Input devices receive MIDI data from external controllers, instruments,
  # or other MIDI sources. Use the class methods to discover and select
  # available input devices.
  #
  # @example List available inputs
  #   MIDICommunications::Input.list
  #
  # @example Open the first input and read messages
  #   input = MIDICommunications::Input.first
  #   messages = input.gets
  #   # => [{ data: [144, 60, 100], timestamp: 1024 }]
  #
  # @example Interactive selection
  #   input = MIDICommunications::Input.gets
  #
  # @example Find by name
  #   input = MIDICommunications::Input.find_by_name("USB MIDI Device")
  #   input.open
  #
  # @see Output For sending MIDI messages
  # @see StreamReader For reading methods (gets, gets_s, etc.)
  #
  # @api public
  class Input
    extend Device::ClassMethods
    include Device::InstanceMethods
    include StreamReader

    # Returns all available MIDI input devices.
    #
    # @return [Array<Input>] array of input devices
    #
    # @example
    #   inputs = MIDICommunications::Input.all
    #   inputs.each { |i| puts i.name }
    def self.all
      Loader.devices(direction: :input)
    end
  end
end
