require 'helper'

module TestHelper
  module Unit
    extend self

    def sysex_ok?
      ENV['_system_name'] != 'OSX' || !RUBY_PLATFORM.include?('java')
    end
  end
end
