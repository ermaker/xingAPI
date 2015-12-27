require 'xingAPI/windows'

module XingAPI
  class FiberedWindows
    attr_accessor :hwnd

    def initialize
      @fiber = Fiber.new do
        win = Windows.new do |*args|
          Fiber.yield(*args)
        end
        Fiber.yield(:hwnd, win.window)
        win.pump_up(time: nil)
      end
      @hwnd = resume { |sig, _| sig == :hwnd }[-1]
    end

    def resume
      loop do
        value = @fiber.resume
        break value if yield(value)
      end
    end

    def resume_login
      resume do |hwnd, msgid, _, _|
        @hwnd == hwnd && msgid == 1024 + 5
      end
    end
  end
end