require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/api'

require 'open3'
require 'multi_json'

module XingAPI
  class Connector
    RUN_COMMAND = %w[bundle exec ruby -Ilib exe\\run.rb]
    def initialize
      @stdin, @stdout, @wait_thr = Open3.popen2(*RUN_COMMAND)
    end

    def run_(*args)
      @stdin.puts(MultiJson.dump(args))
    end
    def run(*args)
      run_(*args)
      MultiJson.load(@stdout.gets)
    end

    def finish
      run_(:exit)
    ensure
      @stdin.close
      @stdout.close
    end
  end
end

c = XingAPI::Connector.new
p c.run(:account, 0)
response = c.run(:tr_t1901, '122630')
puts "#{response['data']['hname'].strip}: #{response['data']['price']} (#{response['data']['diff']}%)"
puts response['message']
c.finish

exit

require 'xingAPI/win32'
require 'message_window'

mw = MessageWindow.new

result = mw.test_
p format('return result: %04x', result)

sleep 1

hwnd = $_message_window_hwnd

loop do
  XingAPI::Windows::Win32.PostMessage(hwnd, 0x400, 0, 0)
  p format('%04x', mw.queue.pop) unless mw.queue.empty?
end

exit

mw = MessageWindow.new
result = mw.create
hwnd = result

p format('%04x', hwnd)

# hwnd = -1
# hwnd = 0

XingAPI::Windows::Win32.PostMessage(hwnd, 0x400, 0, 0)

thread_id_handle = mw.pump

loop do
  XingAPI::Windows::Win32.PostMessage(hwnd, 0x400, 0, 0)
  p format('%04x', mw.queue.pop) unless mw.queue.empty?
  sleep 0.01
end

exit

# api = XingAPI::API.new(ENV['IP'], ENV['PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2'])
# if true
XingAPI::API.new(ENV['IP'], ENV['PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2']) do |api|
  if true
    ::XingAPI::logger.info { "account: #{api.account(0)}" }
  end

  if false
    result = api.tr_CSPAT00600(ENV['ACCOUNT'], ENV['ACCOUNT_PASS'], '114800', 1, :sell)
    ::XingAPI::logger.info { result[:message] }
  end

  if false
    3.times do
      result = api.tr_t1901('122630')
      ::XingAPI::logger.info do
        "#{result[:data][:hname].strip}: #{result[:data][:price]} (#{result[:data][:diff]}%)"
      end
      sleep 2
    end
  end
end
