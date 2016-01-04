require 'dotenv'
Dotenv.load

require 'thread'
require 'xingAPI'
# require 'xingAPI/windows'
require 'xingAPI/api'
require 'xingAPI/threaded_windows'

module XingAPI
  def main
    @win = ThreadedWindows.new
    hwnd = @win.hwnd
    @queue = @win.instance_eval('@queue')

    # Thread.new do
    #   10.times do |idx|
    #     Windows::Win32::PostMessage(@win.hwnd, 1024, idx, idx)
    #   end
    # end

    # 10.times do
    #   ::XingAPI::logger.debug { "Pop: #{@win.resume { true }}" }
    # end
    # ::XingAPI::logger.debug { "Pop finished" }

    ip = ENV['ip']
    port = ENV['PORT']

    ::XingAPI::logger.info { "ip: #{ip}" }
    result = XingAPI.ETK_Connect(hwnd, ip, port.to_i, 1024, -1, 512)
    ::XingAPI::logger.debug { "connect: #{result}" }

    id = ENV['ID']
    pass = ENV['PASS']
    pass2 = ENV['PASS2']

    result = XingAPI.ETK_Login(hwnd, id, pass, pass2, 0, false)
    ::XingAPI::logger.debug { "login: #{result}" }

    p @win.resume { true }

    # _, _, wparam, lparam = @win.resume_login
    # param = [wparam, lparam].map { |p| pointer_to_string(p) }
    # message = "[#{param[0]}] #{param[1]}"
    # ::XingAPI::logger.debug { "login: #{message}" }
  end
  module_function :main
end

XingAPI.main

exit

=begin
@queue = Queue.new
Thread.new do
  @win = XingAPI::Windows.new do |*args|
    ::XingAPI::logger.debug { "WM: #{args}" }
    @queue.push(args)
  end
  @win.pump
end

Thread.new do
  10.times do |idx|
    XingAPI::Windows::Win32::PostMessage(@win.hwnd, 1024, idx, idx)
    # ::XingAPI::logger.debug { "Posted: #{idx}" }
    sleep 0.01
  end
end

10.times do
  ::XingAPI::logger.debug { "Pop: #{@queue.pop}" }
  sleep 0.01
end
::XingAPI::logger.debug { "Pop finished" }
=end

# Thread.abort_on_exception = true
v = XingAPI::API.new(ENV['IP'], ENV['PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2'])
v.logout_
v.disconnect_
