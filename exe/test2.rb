require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/api'
require 'xingAPI/data'

XingAPI::API.new(ENV['IP'], ENV['PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2']) do |api|
  if false
    count = XingAPI::XingAPI.ETK_GetAccountListCount()
    ::XingAPI::logger.info { "AccountListCount: #{count}" }
    p ['account list count', count]

    count.times do |idx|
      out = FFI::MemoryPointer.new(256)
      XingAPI::XingAPI.ETK_GetAccountList(idx, out, out.size)
      ::XingAPI::logger.info { "AccountList: #{out.read_string}" }
    end
  end

  if true
    3.times do
      data = api.tr_t1901('122630')
      ::XingAPI::logger.info { "#{data[:hname].strip}: #{data[:price]} (#{data[:diff]}%)" }
      sleep 4
    end
  end
end
