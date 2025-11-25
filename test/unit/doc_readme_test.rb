require_relative 'helper'

# Tests verifying README examples compile and basic structure is correct
# Note: Examples that require MIDI hardware cannot be fully tested
class MIDICommunications::DocReadmeTest < Minitest::Test
  context 'README examples - library loading' do
    should 'require midi-communications successfully' do
      # Already loaded by helper, verify it worked
      assert defined?(MIDICommunications)
    end
  end

  context 'README examples - class availability' do
    should 'have Output class with list method' do
      # From: MIDICommunications::Output.list
      assert MIDICommunications::Output.respond_to?(:list)
    end

    should 'have Output class with first method' do
      # From: output = MIDICommunications::Output.first
      assert MIDICommunications::Output.respond_to?(:first)
    end

    should 'have Input class with first method' do
      # From: input = MIDICommunications::Input.first
      assert MIDICommunications::Input.respond_to?(:first)
    end

    should 'have Output class with gets method' do
      # From: output = MIDICommunications::Output.gets
      assert MIDICommunications::Output.respond_to?(:gets)
    end

    should 'have Input class with gets method' do
      # From: input = MIDICommunications::Input.gets
      assert MIDICommunications::Input.respond_to?(:gets)
    end
  end

  context 'README examples - Output methods' do
    should 'Output instances respond to puts' do
      # From: output.puts(0x90, 60, 100)
      assert MIDICommunications::Output.method_defined?(:puts)
    end

    should 'Output instances respond to puts_s' do
      # For sending hex strings
      assert MIDICommunications::Output.method_defined?(:puts_s)
    end

    should 'Output instances respond to puts_bytes' do
      assert MIDICommunications::Output.method_defined?(:puts_bytes)
    end

    should 'Output instances respond to puts_bytestr alias' do
      assert MIDICommunications::Output.method_defined?(:puts_bytestr)
    end

    should 'Output instances respond to puts_hex alias' do
      assert MIDICommunications::Output.method_defined?(:puts_hex)
    end
  end

  context 'README examples - Input methods' do
    should 'Input instances respond to gets' do
      # From: messages = input.gets
      assert MIDICommunications::Input.method_defined?(:gets)
    end

    should 'Input instances respond to gets_s' do
      assert MIDICommunications::Input.method_defined?(:gets_s)
    end

    should 'Input instances respond to gets_data' do
      assert MIDICommunications::Input.method_defined?(:gets_data)
    end

    should 'Input instances respond to gets_data_s' do
      assert MIDICommunications::Input.method_defined?(:gets_data_s)
    end
  end

  context 'README examples - device selection' do
    should 'have use method with symbol support' do
      # From: output = MIDICommunications::Output.use(:first)
      assert MIDICommunications::Output.respond_to?(:use)
    end

    should 'have open alias for use' do
      # From: output = MIDICommunications::Output.open(:first)
      assert MIDICommunications::Output.respond_to?(:open)
    end

    should 'have at method for index access' do
      # From: output = MIDICommunications::Output.at(0)
      assert MIDICommunications::Output.respond_to?(:at)
    end

    should 'have [] alias for at' do
      # From: output = MIDICommunications::Output[0]
      assert MIDICommunications::Output.respond_to?(:[])
    end

    should 'have all method' do
      # From: output = MIDICommunications::Output.all[0]
      assert MIDICommunications::Output.respond_to?(:all)
    end

    should 'have find_by_name method' do
      # From: output = MIDICommunications::Output.find_by_name('Roland UM-2 (1)').open
      assert MIDICommunications::Output.respond_to?(:find_by_name)
    end

    should 'have find method from Enumerable' do
      # From: output = MIDICommunications::Output.find { |device| device.name.match(/Launchpad/) }
      assert MIDICommunications::Output.respond_to?(:find)
    end
  end

  context 'README examples - device attributes' do
    should 'Device::InstanceMethods define core methods' do
      # Attribute readers are added via self.included callback to the including class
      # We verify the core methods are defined
      assert MIDICommunications::Device::InstanceMethods.instance_methods.include?(:open)
    end

    should 'Input define direction reader' do
      assert MIDICommunications::Input.method_defined?(:direction)
    end

    should 'Input define id reader' do
      assert MIDICommunications::Input.method_defined?(:id)
    end

    should 'Input define name reader' do
      assert MIDICommunications::Input.method_defined?(:name)
    end

    should 'Input define display_name reader' do
      assert MIDICommunications::Input.method_defined?(:display_name)
    end

    should 'Input define manufacturer reader' do
      assert MIDICommunications::Input.method_defined?(:manufacturer)
    end

    should 'Input define model reader' do
      assert MIDICommunications::Input.method_defined?(:model)
    end

    should 'Input define enabled reader' do
      assert MIDICommunications::Input.method_defined?(:enabled)
    end

    should 'Input define enabled? method' do
      assert MIDICommunications::Input.method_defined?(:enabled?)
    end

    should 'Input define type alias for direction' do
      assert MIDICommunications::Input.method_defined?(:type)
    end
  end

  context 'README examples - device lifecycle' do
    should 'have open method on instances' do
      assert MIDICommunications::Device::InstanceMethods.instance_methods.include?(:open)
    end

    should 'have close method on instances' do
      assert MIDICommunications::Device::InstanceMethods.instance_methods.include?(:close)
    end

    should 'have closed? method on instances' do
      assert MIDICommunications::Device::InstanceMethods.instance_methods.include?(:closed?)
    end
  end
end
