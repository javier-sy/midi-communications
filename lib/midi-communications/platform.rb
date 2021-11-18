module MIDICommunications

  # Deal with different dependencies between different user environments
  module Platform
    extend self

    # Loads the proper MIDI library and adapter for the user's environment
    def bootstrap
      require("midi-communications/adapter/#{platform_lib}")
      Loader.use(platform_module::Loader)
    end

    private

    def platform_lib
      case RUBY_PLATFORM
        when /darwin/ then 'macos'
        when /java/ then 'jruby'
        when /linux/ then 'linux'
        when /mingw/ then 'windows'
      end
    end

    def platform_module
      case RUBY_PLATFORM
        when /darwin/ then Adapter::MacOS
        when /java/ then Adapter::JRuby
        when /linux/ then Adapter::Linux
        when /mingw/ then Adapter::Windows
      end
    end
  end
end
