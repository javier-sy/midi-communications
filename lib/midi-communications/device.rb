module MIDICommunications
  # Common logic shared by both {Input} and {Output} devices.
  #
  # This module provides the core device management functionality including
  # device discovery, selection, and lifecycle management.
  #
  # @api private
  module Device
    # Class methods shared by both {Input} and {Output} classes.
    #
    # Provides device discovery and selection methods including enumeration,
    # listing, searching by name, and interactive selection.
    #
    # @api public
    module ClassMethods
      include Enumerable

      # Iterates over all devices of this type.
      #
      # @yield [device] each device
      # @yieldparam device [Input, Output] a MIDI device
      # @return [Enumerator] if no block given
      #
      # @example
      #   MIDICommunications::Output.each { |o| puts o.name }
      def each(&block)
        all.each(&block)
      end

      # Prints the ID and name of each device to the console.
      #
      # @return [Array<String>] array of formatted device names
      #
      # @example
      #   MIDICommunications::Output.list
      #   # 0) IAC Driver Bus 1
      #   # 1) USB MIDI Device
      def list
        all.map do |device|
          name = "#{device.id}) #{device.display_name}"
          puts(name)
          name
        end
      end

      # Finds a device by its name.
      #
      # @param name [String, Symbol] the device name to search for
      # @return [Input, Output, nil] the matching device or nil if not found
      #
      # @example
      #   output = MIDICommunications::Output.find_by_name("IAC Driver Bus 1")
      def find_by_name(name)
        all.find { |device| name.to_s == device.name }
      end

      # Interactive console prompt for device selection.
      #
      # Displays available devices and waits for user input. When a valid
      # selection is received, the device is opened and returned.
      #
      # @yield [device] optional block to execute with the opened device
      # @yieldparam device [Input, Output] the selected device
      # @return [Input, Output] the selected and opened device
      #
      # @example
      #   output = MIDICommunications::Output.gets
      #   # Select a MIDI output...
      #   # 0) IAC Driver Bus 1
      #   # > 0
      def gets(&block)
        device = nil
        direction = get_direction
        puts ''
        puts "Select a MIDI #{direction}..."
        while device.nil?
          list
          print '> '
          selection = $stdin.gets.chomp
          if selection != ''
            selection = Integer(selection) rescue nil
            device = all.find { |d| d.id == selection } unless selection.nil?
          end
        end
        device.open(&block)
        device
      end

      # Selects and opens the first available device.
      #
      # @yield [device] optional block to execute with the device
      # @yieldparam device [Input, Output] the device
      # @return [Input, Output] the first device, opened
      #
      # @example
      #   output = MIDICommunications::Output.first
      def first(&block)
        use_device(all.first, &block)
      end

      # Selects and opens the last available device.
      #
      # @yield [device] optional block to execute with the device
      # @yieldparam device [Input, Output] the device
      # @return [Input, Output] the last device, opened
      #
      # @example
      #   output = MIDICommunications::Output.last
      def last(&block)
        use_device(all.last, &block)
      end

      # Selects and opens the device at the given index.
      #
      # @param index [Integer, Symbol] device index or :first/:last
      # @yield [device] optional block to execute with the device
      # @yieldparam device [Input, Output] the device
      # @return [Input, Output] the selected device, opened
      #
      # @example
      #   output = MIDICommunications::Output.use(0)
      def use(index, &block)
        index = case index
                when :first then 0
                when :last then all.count - 1
                else index
                end
        use_device(at(index), &block)
      end
      alias open use

      # Returns the device at the given index without opening it.
      #
      # @param index [Integer] device index
      # @return [Input, Output] the device at the given index
      #
      # @example
      #   device = MIDICommunications::Output.at(0)
      #   device.open if device
      def at(index)
        all[index]
      end
      alias [] at

      private

      # The direction of the device eg "input", "output"
      # @return [String]
      def get_direction
        name.split('::').last.downcase
      end

      # Enable the given device
      # @param [Input, Output] device
      # @return [Input, Output]
      def use_device(device, &block)
        if device.enabled?
          yield(device) if block_given?
        else
          device.open(&block)
        end
        device
      end
    end

    # Instance methods shared by both {Input} and {Output} instances.
    #
    # Provides device lifecycle management (open, close) and access
    # to device attributes (name, id, manufacturer, etc.).
    #
    # @api public
    module InstanceMethods
      # Creates a new device wrapper.
      #
      # @param device [Object] platform-specific device object
      # @api private
      def initialize(device)
        @device = device
        @enabled = false

        populate_from_device
      end

      # Opens the device for use.
      #
      # When a block is given, the device is automatically closed when
      # the block exits. Otherwise, the device is closed at program exit.
      #
      # @param args [Object] arguments passed to the underlying device
      # @yield [device] optional block to execute with the open device
      # @yieldparam device [Input, Output] self
      # @return [Input, Output] self
      #
      # @example Open and close automatically with block
      #   output.open do |o|
      #     o.puts(0x90, 60, 100)
      #   end  # device closed here
      #
      # @example Open manually (closed at program exit)
      #   output.open
      #   output.puts(0x90, 60, 100)
      def open(*args)
        unless @enabled
          @device.open(*args)
          @enabled = true
        end
        if block_given?
          begin
            yield(self)
          ensure
            close
          end
        else
          at_exit do
            close
          end
        end
        self
      end

      # Closes the device.
      #
      # @param args [Object] arguments passed to the underlying device
      # @return [Boolean] true if the device was closed, false if already closed
      #
      # @example
      #   output.close
      def close(*args)
        if @enabled
          @device.close(*args)
          @enabled = false
          true
        else
          false
        end
      end

      # Returns true if the device is closed (not enabled).
      #
      # @return [Boolean] true if device is closed
      def closed?
        !@enabled
      end

      # @!attribute [r] direction
      #   @return [Symbol] the device direction (:input or :output)

      # @!attribute [r] enabled
      #   @return [Boolean] whether the device is currently open

      # @!attribute [r] id
      #   @return [Integer] the device ID

      # @!attribute [r] manufacturer
      #   @return [String] the device manufacturer name

      # @!attribute [r] model
      #   @return [String] the device model name

      # @!attribute [r] name
      #   @return [String] the device name

      # @!attribute [r] display_name
      #   @return [String] the device display name

      # @!method enabled?
      #   @return [Boolean] alias for {#enabled}

      # @!method type
      #   @return [Symbol] alias for {#direction}

      # @api private
      def self.included(base)
        base.send(:attr_reader, :direction)
        base.send(:attr_reader, :enabled)
        base.send(:attr_reader, :id)
        base.send(:attr_reader, :manufacturer)
        base.send(:attr_reader, :model)
        base.send(:attr_reader, :name)
        base.send(:attr_reader, :display_name)
        base.send(:alias_method, :enabled?, :enabled)
        base.send(:alias_method, :type, :direction)
      end

      private

      # Populate the direction attribute
      def populate_direction
        @direction = case @device.type
                     when :source, :input then :input
                     when :destination, :output then :output
                     end
      end

      # Populate attributes from the underlying device object
      def populate_from_device
        @id = @device.id

        @manufacturer = @device.manufacturer
        @model = @device.model
        @name = @device.name
        @display_name = @device.display_name

        populate_direction
      end
    end
  end
end
