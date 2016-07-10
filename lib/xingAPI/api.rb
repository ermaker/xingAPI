require 'xingAPI/xingAPI'
require 'xingAPI/fibered_windows'
require 'xingAPI/data'
require 'ffi'

module XingAPI
  class API
    extend Forwardable
    attr_reader :win
    def_delegators :@win, :hwnd

    def initialize(ip, port, id, pass, pass2, &blk)
      @ip = ip
      @port = port.to_i
      @id = id
      @pass = pass
      @pass2 = pass2
      @win = FiberedWindows.new
      connect_and_login(&blk)
    end

    def connect_and_login
      if block_given?
        connect do
          login do
            yield self
          end
        end
      else
        connect_ && login_
      end
    end

    MESSAGE_ID = 1024

    def connect_
      ::XingAPI::logger.info { "ip: #{@ip}" }
      result = XingAPI.ETK_Connect(hwnd, @ip, @port, MESSAGE_ID, -1, 512)
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

    def connect
      yield if connect_
    ensure
      disconnect_
    end

    def pointer_to_string(pointer)
      FFI::Pointer.new(pointer).read_string.force_encoding('cp949')
    end

    def login_
      result = XingAPI.ETK_Login(hwnd, @id, @pass, @pass2, 0, false)
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

    def login
      yield if login_
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
        STRUCT_CSPAT00600InBlock1: {
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

    XM_DISCONNECT = MESSAGE_ID + 1
    XM_RECEIVE_DATA = MESSAGE_ID + 3
    XM_TIMEOUT = MESSAGE_ID + 7

    HANDLE_MESSAGES = [XM_DISCONNECT, XM_RECEIVE_DATA, XM_TIMEOUT]

    RECONNECT_MESSAGE_CODES = ['-10054', '   -2']

    def tr(tr_name, **input)
      is_continue = input.delete(:is_continue) || false
      result = { response: [], message: [] }

      in_block = ::XingAPI.const_get(:"STRUCT_#{tr_name}InBlock").new
      in_block.assign(input)

      request_id = XingAPI.ETK_Request(hwnd, tr_name, in_block, in_block.size, is_continue, nil, 1)
      ::XingAPI::logger.debug { "request_id: #{request_id}" }

      loop do
        _, msgid, wparam, lparam = @win.resume { |_, msgid, _, _| HANDLE_MESSAGES.include?(msgid) }
        case msgid
        when XM_RECEIVE_DATA
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
            if RECONNECT_MESSAGE_CODES.include?(msg.szMsgCode)
              logout_
              disconnect_
              connect_and_login
            end
            break
          when 4
            ::XingAPI::logger.debug { "WM_RECEIVE_DATA: Release (#{lparam})" }
            XingAPI.ETK_ReleaseRequestData(lparam)
            break
          else
            ::XingAPI::logger.warn { "WM_RECEIVE_DATA: Unknown case! (#{wparam})" }
          end
        when XM_DISCONNECT
          ::XingAPI::logger.warn { 'XM_DISCONNECT' }
          result[:message].push '[-4225] XM_DISCONNECT'
          disconnect_
          connect_and_login
          break
        when XM_TIMEOUT
          ::XingAPI::logger.warn { "XM_TIMEOUT: Release (#{lparam})" }
          result[:message].push "[-4226] XM_TIMEOUT(#{lparam})"
          XingAPI.ETK_ReleaseRequestData(lparam)
          break
        end
      end

      return result
    end

    def account(idx)
      XingAPI.account(idx)
    end
  end
end
