require 'xingAPI/win32'
require 'ffi'

module XingAPI
  # Utilises the Windows API to send and receive Window Messages to/from
  # Skype.
  #
  # This protocol is only available on Windows and Cygwin.
  class Windows
    attr_accessor :window
    alias_method :hwnd, :window

    # Sets up access to Skype
    #
    # @see http://msdn.microsoft.com/en-us/library/bb384843.aspx Creating
    #     Win32-Based Applications
    def initialize(&blk)
      instance = Win32::GetModuleHandle(nil)

      @window_class = Win32::WNDCLASSEX.new
      @window_class[:style]         = Win32::CS_HREDRAW | Win32::CS_VREDRAW
      @window_class[:lpfnWndProc]   = Proc.new do |*args|
        blk.call(*args)
        Win32::DefWindowProc(*args)
      end
      @window_class[:hInstance]     = instance
      @window_class[:hbrBackground] = Win32::COLOR_WINDOW
      @window_class[:lpszClassName] =
          FFI::MemoryPointer.from_string 'xingAPI-ruby'

      @window = Win32::CreateWindowEx(Win32::WS_EX_LEFT,
                                      FFI::Pointer.new(@window_class.handle),
                                      'xingAPI-ruby',
                                      Win32::WS_OVERLAPPEDWINDOW,
                                      0, 0, 0, 0, Win32::NULL, Win32::NULL,
                                      instance, nil)
    end

    # Update processing.
    #
    # This executes a Windows event loop while there are messages still
    # pending, then dumps back out to let other things take over and do their
    # thing.
    #
    # @return [void]
    def tick
      msg = Win32::MSG.new
      while Win32::PeekMessage(msg, Win32::NULL, 0, 0, Win32::PM_REMOVE) > 0
        # puts "WAIT: #{msg[:hwnd]}, #{msg[:message]}, #{msg[:wParam]}, #{msg[:lParam]}"
        Win32::TranslateMessage(msg)
        Win32::DispatchMessage(msg)
      end
    end

    def pump_up(time: 1)
      step = 0.01
      (time ? (time / step).to_i.times : loop).each do
        tick
        sleep step
      end
    end
  end
end
