require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/api'
require 'xingAPI/data'

module XingAPI
  def main
    @win = FiberedWindows.new
    hwnd = @win.hwnd
    ip = ENV['IP']
    port = ENV['PORT']

    id = ENV['ID']
    pass = ENV['PASS']
    pass2 = ENV['PASS2']


    result = XingAPI.ETK_Connect(hwnd, ip, port.to_i, 1024, -1, 512)
    ::XingAPI::logger.debug { "connect: #{result}" }

    result = XingAPI.ETK_Login(hwnd, id, pass, pass2, 0, false)
    ::XingAPI::logger.debug { "login: #{result}" }
    unless result
      ::XingAPI::logger.error { "login: #{result}" }
      return
    end

    _, _, wparam, lparam = @win.resume_login
    result = [wparam, lparam].map { |param| pointer_to_string(param) }
    message = "[#{result[0]}] #{result[1]}"
    ::XingAPI::logger.debug { "login: #{message}" }

    unless pointer_to_string(wparam) == '0000'
      ::XingAPI::logger.error { "login: #{message}" }
      return
    end
  end

  module_function :main
end

XingAPI.main