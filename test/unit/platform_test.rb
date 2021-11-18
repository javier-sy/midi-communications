require_relative 'helper'

class MIDICommunications::PlatformTest < Minitest::Test
  context 'Platform' do
    context '.bootstrap' do
      if RUBY_PLATFORM.include?('java')
        should 'recognize java' do
          assert_equal(MIDICommunications::Adapter::JRuby::Loader, MIDICommunications::Loader.instance_variable_get('@loader'))
        end
      end

      if RUBY_PLATFORM.include?('linux')
        should 'recognize linux' do
          assert_equal(MIDICommunications::Adapter::Linux::Loader, MIDICommunications::Loader.instance_variable_get('@loader'))
        end
      end

      if RUBY_PLATFORM.include?('darwin')
        should 'recognize osx' do
          assert_equal(MIDICommunications::Adapter::MacOS::Loader, MIDICommunications::Loader.instance_variable_get('@loader'))
        end
      end

      if RUBY_PLATFORM.include?('mingw')
        should 'recognize windows' do
          assert_equal(MIDICommunications::Adapter::Windows::Loader, MIDICommunications::Loader.instance_variable_get('@loader'))
        end
      end
    end
  end
end
