require 'xingAPI/windows'
require 'forwardable'

module XingAPI
  class ThreadedWindows
    extend Forwardable
    attr_reader :win
    def_delegators :@win, :hwnd

    def initialize
      @queue = Queue.new
      Thread.abort_on_exception = true
      Thread.new do
        @win = Windows.new do |*args|
          ::XingAPI::logger.debug { "WM: #{args}" }
          @queue.push(args)
        end
        @queue.push(:hwnd)
        @win.pump
      end
      resume { |msg| msg == :hwnd }
      ::XingAPI::logger.debug { "hwnd: #{hwnd}" }
    end

    def resume
      loop do
        value = @queue.pop
        break value if yield(value)
      end
    end

    def resume_login
      resume do |hwnd_, msgid, _, _|
        ::XingAPI::logger.debug { "resume_login: #{hwnd_}, #{msgid}" }
        hwnd == hwnd_ && msgid == 1024 + 5
      end
    end
  end
end