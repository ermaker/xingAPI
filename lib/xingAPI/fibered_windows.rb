require 'xingAPI/windows'
require 'forwardable'

module XingAPI
  class FiberedWindows
    extend Forwardable
    attr_reader :win
    def_delegators :@win, :hwnd

    def initialize
      @fiber = Fiber.new do
        @win = Windows.new do |*args|
          ::XingAPI::logger.debug { "args: #{args}" }
          begin
            Fiber.yield(*args)
          rescue FiberError
            ::XingAPI::logger.warn { 'FiberError' }
          end
        end
        :finish
      end
      resume_finish
      ::XingAPI::logger.debug { "hwnd: #{hwnd}" }
    end

    def resume(&blk)
      @fiber = Fiber.new do
        @win.pump_up(time: nil)
        :finish
      end

      resume_(&blk)
    ensure
      resume_finish
    end

    def resume_
      loop do
        value = @fiber.resume
        if yield(value)
          @win.finish!
          break value
        end
      end
    end

    def resume_finish
      resume_ { |sig,| sig == :finish }
    end

    def resume_login
      resume do |hwnd_, msgid, _, _|
        hwnd == hwnd_ && msgid == 1024 + 5
      end
    end
  end
end