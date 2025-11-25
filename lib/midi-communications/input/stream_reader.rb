module MIDICommunications
  class Input
    # Methods for reading MIDI messages from an input device.
    #
    # Provides multiple methods for retrieving MIDI data in different formats:
    # numeric bytes, hex strings, or raw data arrays.
    #
    # @api public
    module StreamReader
      # Reads MIDI messages from the input buffer.
      #
      # Returns all messages received since the last read. Each message
      # includes the MIDI data and a timestamp.
      #
      # @param args [Object] arguments passed to the underlying device
      # @return [Array<Hash>] array of message hashes with :data and :timestamp keys
      #
      # @example
      #   messages = input.gets
      #   # => [{ data: [144, 60, 100], timestamp: 1024 },
      #   #     { data: [128, 60, 100], timestamp: 1100 }]
      #
      # @example Process messages in a loop
      #   loop do
      #     messages = input.gets
      #     messages.each { |m| puts m[:data].inspect }
      #     sleep(0.01)
      #   end
      def gets(*args)
        @device.gets(*args)
      rescue SystemExit, Interrupt
        exit
      end

      # Reads MIDI messages as hex strings.
      #
      # Similar to {#gets} but returns data as hex strings instead of byte arrays.
      #
      # @param args [Object] arguments passed to the underlying device
      # @return [Array<Hash>] array of message hashes with :data (String) and :timestamp keys
      #
      # @example
      #   messages = input.gets_s
      #   # => [{ data: "904060", timestamp: 904 },
      #   #     { data: "804060", timestamp: 1150 }]
      def gets_s(*args)
        @device.gets_s(*args)
      rescue SystemExit, Interrupt
        exit
      end
      alias gets_bytestr gets_s
      alias gets_hex gets_s

      # Reads MIDI data as a flat array of bytes.
      #
      # Returns all message data concatenated into a single array,
      # without timestamps.
      #
      # @param args [Object] arguments passed to the underlying device
      # @return [Array<Integer>] flat array of all MIDI bytes
      #
      # @example
      #   data = input.gets_data
      #   # => [144, 60, 100, 128, 60, 100, 144, 40, 120]
      def gets_data(*args)
        arr = gets(*args)
        arr.map { |msg| msg[:data] }.inject(:+)
      end

      # Reads MIDI data as a concatenated hex string.
      #
      # Returns all message data concatenated into a single hex string,
      # without timestamps.
      #
      # @param args [Object] arguments passed to the underlying device
      # @return [String] concatenated hex string of all MIDI data
      #
      # @example
      #   data = input.gets_data_s
      #   # => "90406080406090447F"
      def gets_data_s(*args)
        arr = gets_bytestr(*args)
        arr.map { |msg| msg[:data] }.join
      end
      alias gets_data_bytestr gets_data_s
      alias gets_data_hex gets_data_s
    end
  end
end
