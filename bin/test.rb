require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/connector'

module XingAPI
  @logger = Logger.new(STDOUT)
  class Connector
    RUN_COMMAND = %w[bundle exec ruby -Ilib exe\\run.rb]
  end
end

api = XingAPI::Connector.new
STDOUT.sync = true
if false
  result = api.tr_t1903('122630')
  ::XingAPI::logger.info do
    result
  end
end
if false
  sleep 2
  result = api.tr_t1903('122630', '20150101')
  ::XingAPI::logger.info do
    result
  end
end
if false
  result = api.tr_t1901('122630')
  ::XingAPI::logger.info do
    "#{result['data']['hname'].strip}: #{result['data']['price']} (#{result['data']['diff']}%)"
  end
end
if false
  loop do
    # ::XingAPI::logger.info { "account: #{api.account(0)}" }
    result = api.tr_t1901('122630')
    ::XingAPI::logger.info do
      "#{result['data']['hname'].strip}: #{result['data']['price']} (#{result['data']['diff']}%)"
    end
    ::XingAPI::logger.info { result['message'] }
    sleep 10
  end
end
if false
  ::XingAPI::logger.info { "account: #{api.account(0)}" }
end
if false
  result = api.tr_CSPAT00600(ENV['ACCOUNT'], ENV['ACCOUNT_PASS'], '114800', 1, :sell)
  ::XingAPI::logger.info { result['message'] }
end
if false
  3.times do
    result = api.tr_t1901('122630')
    ::XingAPI::logger.info do
      "#{result['data']['hname'].strip}: #{result['data']['price']} (#{result['data']['diff']}%)"
    end
    sleep 2
  end
end
api.finish
