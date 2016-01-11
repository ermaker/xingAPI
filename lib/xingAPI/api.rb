require 'xingAPI/xingAPI'
require 'xingAPI/fibered_windows'
require 'xingAPI/data'
require 'ffi'

module XingAPI
  class API
    extend Forwardable
    attr_reader :win
    def_delegators :@win, :hwnd

    def initialize(ip, port, id, pass, pass2)
      @win = FiberedWindows.new
      if block_given?
        connect(ip, port) do
          login(id, pass, pass2) do
            yield self
          end
        end
      else
        connect_(ip, port) && login_(id, pass, pass2)
      end
    end

    def connect_(ip, port)
      ::XingAPI::logger.info { "ip: #{ip}" }
      result = XingAPI.ETK_Connect(hwnd, ip, port.to_i, 1024, -1, 512)
      if result
        ::XingAPI::logger.debug { "connect: #{result}" }
      else
        ::XingAPI::logger.error { "connect: #{result}" }
      end
      result
    end

    def disconnect_
      XingAPI.ETK_Disconnect
      ::XingAPI::logger.debug { 'disconnect' }
    end

    def connect(ip, port)
      yield if connect_(ip, port)
    ensure
      disconnect_
    end

    def pointer_to_string(pointer)
      FFI::Pointer.new(pointer).read_string.force_encoding('cp949')
    end

    def login_(id, pass, pass2)
      result = XingAPI.ETK_Login(hwnd, id, pass, pass2, 0, false)
      if result
        ::XingAPI::logger.debug { "login: #{result}" }
      else
        ::XingAPI::logger.error { "login: #{result}" }
        return false
      end

      _, _, wparam, lparam = @win.resume_login
      param = [wparam, lparam].map { |p| pointer_to_string(p) }
      message = "[#{param[0]}] #{param[1]}"
      ::XingAPI::logger.debug { "login: #{message}" }

      unless pointer_to_string(wparam) == '0000'
        ::XingAPI::logger.error { "login: #{message}" }
      end
      return result
    end

    def logout_
      XingAPI.ETK_Logout(hwnd)
      ::XingAPI::logger.debug { "logout: #{hwnd}" }
    end

    def login(id, pass, pass2)
      yield if login_(id, pass, pass2)
    ensure
      logout_
    end

    def tr_t1901(shcode)
      tr('t1901', shcode: shcode)
    end

    def tr_t1903(shcode, date = '')
      tr(
        't1903',
        is_continue: !date.empty?,
        shcode: shcode, date: date)
    end

    SELL_OR_BUY = {sell: '1', buy: '2'}

    def tr_CSPAT00600(account, account_pass, shcode, qty, sell_or_buy)
      if account.nil? || account.empty?
        account = XingAPI.account(0)
        ::XingAPI::logger.info { "account: #{account}" }
      end
      sell_or_buy = sell_or_buy.to_sym
      price = 0

      tr(
        'CSPAT00600', 
        'STRUCT_CSPAT00600InBlock1': {
          AcntNo: account,
          InptPwd: account_pass,
          IsuNo: "A#{shcode}",
          OrdQty: qty,
          OrdPrc: price,
          BnsTpCode: SELL_OR_BUY.fetch(sell_or_buy),
          OrdprcPtnCode: '03',
          MgntrnCode: '000',
          LoanDt: '00000000',
          OrdCndiTpCode: '0'
        }
      )
    end

    def tr(tr_name, **input)
      is_continue = input.delete(:is_continue) || false
      result = { response: [], message: [] }

      in_block = ::XingAPI.const_get(:"STRUCT_#{tr_name}InBlock").new
      in_block.assign(input)

      request_id = XingAPI.ETK_Request(hwnd, tr_name, in_block, in_block.size, is_continue, nil, 1)
      ::XingAPI::logger.debug { "request_id: #{request_id}" }

      loop do
        _, _, wparam, lparam = @win.resume { |_, msgid, _, _| msgid == 1024 + 3}
        case wparam
        when 1
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Data" }
          recv = RECV_PACKET.of(lparam)
          ::XingAPI::logger.debug { "recv: #{recv.to_hash}" }
          ::XingAPI::logger.debug { "recv: #{recv}" }
          result[:response].push recv.data.to_hash
          ::XingAPI::logger.debug { "recv.data: #{recv.data.to_hash}" }
        when 2
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Message" }
          msg = MSG_PACKET.of(lparam)
          result[:message].push msg.to_s
          ::XingAPI::logger.debug { msg.to_s }
          XingAPI.ETK_ReleaseMessageData(lparam)
        when 3
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Error" }
          msg = MSG_PACKET.of(lparam)
          result[:message].push msg.to_s
          ::XingAPI::logger.debug { msg.to_s }
          XingAPI.ETK_ReleaseMessageData(lparam)
          break
        when 4
          ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Release (#{lparam})" }
          XingAPI.ETK_ReleaseRequestData(lparam)
          break
        else
          ::XingAPI::logger.warn { "WM_RECEIVE_DATA: Unknown case! (#{wparam})" }
        end
      end

      return result
    end

    def account(idx)
      XingAPI.account(idx)
    end
  end
end