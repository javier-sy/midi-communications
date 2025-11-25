module MIDICommunications
  # A MIDI output device for sending MIDI messages.
  #
  # Output devices send MIDI data to external instruments, software synthesizers,
  # or other MIDI destinations. Use the class methods to discover and select
  # available output devices.
  #
  # @example List available outputs
  #   MIDICommunications::Output.list
  #
  # @example Send a note to the first output
  #   output = MIDICommunications::Output.first
  #   output.puts(0x90, 60, 100)  # Note On, middle C, velocity 100
  #   sleep(0.5)
  #   output.puts(0x80, 60, 0)    # Note Off
  #
  # @example Send messages as hex strings
  #   output = MIDICommunications::Output.first
  #   output.puts_s("904060")     # Note On
  #   output.puts_s("804060")     # Note Off
  #
  # @example Interactive selection
  #   output = MIDICommunications::Output.gets
  #
  # @example Find by name
  #   output = MIDICommunications::Output.find_by_name("IAC Driver Bus 1")
  #   output.open
  #
  # @see Input For receiving MIDI messages
  #
  # @api public
  class Output
    extend Device::ClassMethods
    include Device::InstanceMethods

    # Returns all available MIDI output devices.
    #
    # @return [Array<Output>] array of output devices
    #
    # @example
    #   outputs = MIDICommunications::Output.all
    #   outputs.each { |o| puts o.name }
    def self.all
      Loader.devices(direction: :output)
    end

    # Sends a MIDI message to the output.
    #
    # Accepts multiple message formats for flexibility:
    # - Numeric bytes: `output.puts(0x90, 0x40, 0x40)`
    # - Array of numeric bytes: `output.puts([0x90, 0x40, 0x40])`
    # - Hex string: `output.puts("904040")`
    # - Array of strings: `output.puts(["904040", "804040"])`
    # - Objects with `to_bytes` method: `output.puts(midi_event)`
    #
    # @param messages [Array<Integer>, Array<String>, Integer, String] MIDI messages in any supported format
    # @return [Array<Integer>, Array<String>] the messages sent
    #
    # @example Send Note On as bytes
    #   output.puts(0x90, 60, 100)
    #
    # @example Send Note On as array
    #   output.puts([0x90, 60, 100])
    #
    # @example Send Note On as hex string
    #   output.puts("903C64")
    def puts(*messages)
      message = messages.first
      case message
      when Array then messages.each { |array| puts(*array.flatten) }
      when Integer then puts_bytes(*messages)
      when String then puts_s(*messages)
      else
        if message.respond_to?(:to_bytes)
          puts_bytes(*message.to_bytes.flatten)
        elsif message.respond_to?(:to_a)
          puts_bytes(*message.to_a.flatten)
        end
      end
    end

    # Sends a MIDI message as a hex string.
    #
    # This is a lower-level method that does not perform type checking.
    # Use {#puts} for automatic format detection.
    #
    # @param messages [String] one or more hex strings (e.g., "904040")
    # @return [String, Array<String>] the message(s) sent
    #
    # @example
    #   output.puts_s("904060")  # Note On
    #   output.puts_s("804060")  # Note Off
    def puts_s(*messages)
      @device.puts_s(*messages)
      messages.count < 2 ? messages[0] : messages
    end
    alias puts_bytestr puts_s
    alias puts_hex puts_s

    # Sends a MIDI message as numeric bytes.
    #
    # This is a lower-level method that does not perform type checking.
    # Use {#puts} for automatic format detection.
    #
    # @param messages [Integer] numeric byte values (e.g., 0x90, 0x40, 0x40)
    # @return [Integer, Array<Integer>] the message bytes sent
    #
    # @example
    #   output.puts_bytes(0x90, 0x40, 0x40)  # Note On, note 64, velocity 64
    def puts_bytes(*messages)
      @device.puts_bytes(*messages)
      messages.count < 2 ? messages[0] : messages
    end
  end
end
