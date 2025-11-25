module MIDICommunications
  # Handles platform detection and adapter loading.
  #
  # Automatically detects the current platform (macOS, Linux, Windows, JRuby)
  # and loads the appropriate low-level MIDI adapter.
  #
  # @api private
  module Platform
    extend self

    # Loads the correct MIDI adapter for the current platform.
    #
    # Called automatically when the library is required. Detects the
    # platform and loads the corresponding adapter gem.
    #
    # @return [void]
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
