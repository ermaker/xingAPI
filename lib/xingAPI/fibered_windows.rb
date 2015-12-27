require 'xingAPI/windows'

module XingAPI
  class FiberedWindows
    attr_reader :win
    def hwnd
      @win.hwnd
    end

    def initialize
      @fiber = Fiber.new do
        @win = Windows.new do |*args|
          ::XingAPI::logger.debug { "args: #{args}" }
          Fiber.yield(*args)
          Windows::Win32::DefWindowProc(*args).tap { Fiber.yield(:nop) }
        end
        Fiber.yield(:hwnd)
        @win.pump_up(time: nil)
      end
      resume { |sig,| sig == :hwnd }
      ::XingAPI::logger.debug { "hwnd: #{hwnd}" }
    end

    def resume
      loop do
        value = @fiber.resume
        break value if yield(value)
      end
    end

    def resume_nop
      resume { |sig,| sig == :nop }.tap do
        ::XingAPI::logger.debug { 'resume_nop' }
      end
    end

    def resume_login
      resume do |hwnd_, msgid, _, _|
        hwnd == hwnd_ && msgid == 1024 + 5
      end.tap { resume_nop }
    end
  end
end