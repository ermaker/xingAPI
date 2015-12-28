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
    @win = api.instance_eval('@win')
    hwnd = api.hwnd

    account = ENV['ACCOUNT']
    account_pass = ENV['ACCOUNT_PASS']
    shcode = '122630'
    qty = 10
    price = 0
    sell_or_buy = '2'

    order = XingAPI::STRUCT_CSPAT00600InBlock1.new
    order[:AcntNo].to_ptr.write_string(account.ljust(20))
    order[:InptPwd].to_ptr.write_string(account_pass.ljust(8))
    order[:IsuNo].to_ptr.write_string("A#{shcode}".ljust(12))
    order[:OrdQty].to_ptr.write_string(format('%016d', qty))
    order[:OrdPrc].to_ptr.write_string(format('%011.2f', price))
    order[:BnsTpCode].to_ptr.write_string(sell_or_buy)
    order[:OrdprcPtnCode].to_ptr.write_string('03')
    order[:MgntrnCode].to_ptr.write_string('000')
    order[:LoanDt].to_ptr.write_string('00000000')
    order[:OrdCndiTpCode].to_ptr.write_string('0')

    request_id = XingAPI::XingAPI.ETK_Request(hwnd, 'CSPAT00600', order, order.size, false, nil, 1)
    ::XingAPI::logger.debug { "request_id: #{request_id}" }

    loop do
      _, _, wparam, lparam = @win.resume { |_, msgid, _, _| msgid == 1024 + 3}
      ::XingAPI::logger.debug { "WM_RECEIVE_DATA:" }
      case wparam
      when 1
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Data" }
        recv = XingAPI::RECV_PACKET.of(lparam)
        ::XingAPI::logger.debug { recv.to_s }
        # require 'pry'
        # binding.pry
        ::XingAPI::logger.debug { recv.szTrCode }
        ::XingAPI::logger.debug { recv.nDataMode }
        ::XingAPI::logger.debug { recv.nDataLength }

        result = recv.data(block_name: 'CSPAT00600OutBlock1').to_hash
        ::XingAPI::logger.debug { result.to_s }
        # result = recv.data(block_name: 'CSPAT00600OutBlock2').to_hash
        # ::XingAPI::logger.debug { result.to_s }
        result = ::XingAPI::STRUCT_CSPAT00600OutBlock2.of(recv.lpData + ::XingAPI::STRUCT_CSPAT00600OutBlock1.size).to_hash
        ::XingAPI::logger.debug { result.to_s }
      when 2
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Message" }
        msg = XingAPI::MSG_PACKET.of(lparam)
        ::XingAPI::logger.debug { msg.to_s }

        XingAPI::XingAPI.ETK_ReleaseMessageData(lparam)
      when 3
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Error" }
        msg = XingAPI::MSG_PACKET.of(lparam)
        ::XingAPI::logger.debug { msg.to_s }

        XingAPI::XingAPI.ETK_ReleaseMessageData(lparam)
        break
      when 4
        ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Release" }
        XingAPI::XingAPI.ETK_ReleaseRequestData(lparam)
        break
      else
        ::XingAPI::logger.error { "Unknown case! wpararm: #{wparam}" }
      end
    end
  end

  if false
    3.times do
      data = api.tr_t1901('122630')
      ::XingAPI::logger.info { "#{data[:hname].strip}: #{data[:price]} (#{data[:diff]}%)" }
      sleep 4
    end
  end

  if true
    fiber = api.instance_eval('@win').instance_eval('@fiber')
    p fiber.alive?
  end
end
