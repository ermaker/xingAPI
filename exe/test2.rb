require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/api'
require 'xingAPI/data'

XingAPI::API.new do |api|
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
    win = api.instance_eval('@win')
    hwnd = api.hwnd

    t1901 = XingAPI::STRUCT_t1901InBlock.new
    t1901[:shcode].to_ptr.write_string('122630')

    request_id = XingAPI::XingAPI.ETK_Request(hwnd, 't1901', t1901, t1901.size, false, nil, 1)
    ::XingAPI::logger.debug { "request_id: #{request_id}" }

    loop do
      _, _, wparam, lparam = win.resume { |_, msgid, _, _| msgid == 1024 + 3}
      ::XingAPI::logger.debug { "WM_RECEIVE_DATA:" }
      case wparam
      when 1
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Data" }
        recv = XingAPI::RECV_PACKET.of(lparam)
        ::XingAPI::logger.debug { recv.to_s }
        ::XingAPI::logger.debug { recv.data.to_hash.to_s }
      when 2, 3
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Message" }
        msg = XingAPI::MSG_PACKET.of(lparam)
        ::XingAPI::logger.debug { msg.to_s }

        XingAPI::XingAPI.ETK_ReleaseMessageData(lparam)
      when 4
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Release" }
        XingAPI::XingAPI.ETK_ReleaseRequestData(lparam)
        break
      else
        ::XingAPI::logger.error { "Unknown case! wpararm: #{wparam}" }
      end
    end
  end
end
