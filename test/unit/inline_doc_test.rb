require_relative 'helper'

# Tests for inline documentation examples
# Note: Most MIDI operations require actual hardware devices.
# These tests verify the examples that don't require hardware.
class MIDICommunications::InlineDocTest < Minitest::Test
  context 'TypeConversion documentation examples' do
    context '#numeric_byte_array_to_hex_string' do
      should 'convert Note On bytes to hex string (from @example)' do
        result = MIDICommunications::TypeConversion.numeric_byte_array_to_hex_string([0x90, 0x40, 0x40])
        assert_equal '904040', result
      end

      should 'convert Note Off bytes to hex string' do
        result = MIDICommunications::TypeConversion.numeric_byte_array_to_hex_string([0x80, 0x40, 0x40])
        assert_equal '804040', result
      end

      should 'convert Control Change bytes to hex string' do
        result = MIDICommunications::TypeConversion.numeric_byte_array_to_hex_string([0xB0, 0x07, 0x7F])
        assert_equal 'b077f', result
      end

      should 'handle empty array' do
        result = MIDICommunications::TypeConversion.numeric_byte_array_to_hex_string([])
        assert_equal '', result
      end

      should 'convert single byte' do
        result = MIDICommunications::TypeConversion.numeric_byte_array_to_hex_string([0xF0])
        assert_equal 'f0', result
      end
    end
  end

  context 'Module structure' do
    should 'have Input class' do
      assert defined?(MIDICommunications::Input)
    end

    should 'have Output class' do
      assert defined?(MIDICommunications::Output)
    end

    should 'have Device module' do
      assert defined?(MIDICommunications::Device)
    end

    should 'have TypeConversion module' do
      assert defined?(MIDICommunications::TypeConversion)
    end

    should 'have Platform module' do
      assert defined?(MIDICommunications::Platform)
    end

    should 'have Loader class' do
      assert defined?(MIDICommunications::Loader)
    end

    should 'have VERSION constant' do
      assert defined?(MIDICommunications::VERSION)
      assert_kind_of String, MIDICommunications::VERSION
    end
  end

  context 'Device::ClassMethods' do
    should 'Input include Enumerable' do
      assert MIDICommunications::Input.respond_to?(:each)
    end

    should 'Output include Enumerable' do
      assert MIDICommunications::Output.respond_to?(:each)
    end

    should 'Input respond to class methods' do
      assert MIDICommunications::Input.respond_to?(:all)
      assert MIDICommunications::Input.respond_to?(:list)
      assert MIDICommunications::Input.respond_to?(:find_by_name)
      assert MIDICommunications::Input.respond_to?(:gets)
      assert MIDICommunications::Input.respond_to?(:first)
      assert MIDICommunications::Input.respond_to?(:last)
      assert MIDICommunications::Input.respond_to?(:use)
      assert MIDICommunications::Input.respond_to?(:open)
      assert MIDICommunications::Input.respond_to?(:at)
      assert MIDICommunications::Input.respond_to?(:[])
    end

    should 'Output respond to class methods' do
      assert MIDICommunications::Output.respond_to?(:all)
      assert MIDICommunications::Output.respond_to?(:list)
      assert MIDICommunications::Output.respond_to?(:find_by_name)
      assert MIDICommunications::Output.respond_to?(:gets)
      assert MIDICommunications::Output.respond_to?(:first)
      assert MIDICommunications::Output.respond_to?(:last)
      assert MIDICommunications::Output.respond_to?(:use)
      assert MIDICommunications::Output.respond_to?(:open)
      assert MIDICommunications::Output.respond_to?(:at)
      assert MIDICommunications::Output.respond_to?(:[])
    end
  end

  context 'Device::InstanceMethods' do
    should 'Input instances respond to instance methods' do
      # We can check the module methods exist without creating instances
      assert MIDICommunications::Device::InstanceMethods.instance_methods.include?(:open)
      assert MIDICommunications::Device::InstanceMethods.instance_methods.include?(:close)
      assert MIDICommunications::Device::InstanceMethods.instance_methods.include?(:closed?)
    end
  end

  context 'StreamReader methods' do
    should 'Input instances have StreamReader methods' do
      # StreamReader is included without full namespace, check methods exist
      assert MIDICommunications::Input.method_defined?(:gets)
      assert MIDICommunications::Input.method_defined?(:gets_s)
    end

    should 'StreamReader define gets methods' do
      methods = MIDICommunications::Input::StreamReader.instance_methods
      assert methods.include?(:gets)
      assert methods.include?(:gets_s)
      assert methods.include?(:gets_data)
      assert methods.include?(:gets_data_s)
      assert methods.include?(:gets_bytestr)
      assert methods.include?(:gets_hex)
      assert methods.include?(:gets_data_bytestr)
      assert methods.include?(:gets_data_hex)
    end
  end
end
