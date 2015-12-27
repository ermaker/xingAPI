require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/fibered_windows'
require 'xingAPI/api'

XingAPI::API.new do
  count = XingAPI::XingAPI.ETK_GetAccountListCount()
  p ['account list count', count]

  count.times do |idx|
    out = FFI::MemoryPointer.new(256)
    XingAPI::XingAPI.ETK_GetAccountList(idx, out, out.size)
    p out.read_string
  end
end
