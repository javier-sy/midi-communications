module MIDICommunications
  # Populates MIDI devices using platform-specific adapters.
  #
  # This class lazily loads and caches MIDI devices from the underlying
  # platform adapter (macOS, Linux, Windows, or JRuby).
  #
  # @api private
  class Loader
    class << self
      # Sets the platform-specific loader to use.
      #
      # @param loader [Module] a loader module with `inputs` and `outputs` methods
      # @return [Module] the loader
      def use(loader)
        @loader = loader
      end

      # Returns all MIDI devices, optionally filtered by direction.
      #
      # Lazily loads and caches devices from the platform adapter on first call.
      #
      # @param options [Hash] filter options
      # @option options [Symbol] :direction Return only :input or :output devices
      # @return [Array<Input>, Array<Output>] array of devices
      def devices(options = {})
        if @devices.nil?
          inputs = @loader.inputs.map { |device| ::MIDICommunications::Input.new(device) }
          outputs = @loader.outputs.map { |device| ::MIDICommunications::Output.new(device) }
          @devices = {
            input: inputs,
            output: outputs
          }
        end
        options[:direction].nil? ? @devices.values.flatten : @devices[options[:direction]]
      end
    end
  end
end
