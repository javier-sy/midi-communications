module MIDICommunications
  # Utility methods for converting between MIDI data formats.
  #
  # @api public
  module TypeConversion
    extend self

    # Converts an array of numeric bytes to a hex string.
    #
    # @param bytes [Array<Integer>] array of numeric bytes (e.g., [0x90, 0x40, 0x40])
    # @return [String] hex string representation (e.g., "904040")
    #
    # @example
    #   TypeConversion.numeric_byte_array_to_hex_string([0x90, 0x40, 0x40])
    #   # => "904040"
    def numeric_byte_array_to_hex_string(bytes)
      bytes.map { |b| b.to_s(16) }.join
    end
  end
end
