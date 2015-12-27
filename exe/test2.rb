require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/api'

XingAPI::API.new do
  count = XingAPI::XingAPI.ETK_GetAccountListCount()
  ::XingAPI::logger.info { "AccountListCount: #{count}" }
  p ['account list count', count]

  count.times do |idx|
    out = FFI::MemoryPointer.new(256)
    XingAPI::XingAPI.ETK_GetAccountList(idx, out, out.size)
    ::XingAPI::logger.info { "AccountList: #{out.read_string}" }
  end
end
