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
  response = result['response'].last
  ::XingAPI::logger.info do
    "#{response['hname'].strip}: #{response['price']} (#{response['diff']}%)"
  end
end
if false
  loop do
    # ::XingAPI::logger.info { "account: #{api.account(0)}" }
    result = api.tr_t1901('122630')
    response = result['response'].last
    ::XingAPI::logger.info do
      "#{response['hname'].strip}: #{response['price']} (#{response['diff']}%)"
    end
    ::XingAPI::logger.info { result['message'].join(', ') }
    sleep 10
  end
end
if false
  ::XingAPI::logger.info { "account: #{api.account(0)}" }
end
if false
  result = api.tr_CSPAT00600(ENV['ACCOUNT'], ENV['ACCOUNT_PASS'], '114800', 1, :sell)
  ::XingAPI::logger.info { result['message'].join(', ') }
end
if false
  3.times do
    result = api.tr_t1901('122630')
    response = result['response'].last
    ::XingAPI::logger.info do
      "#{response['hname'].strip}: #{response['price']} (#{response['diff']}%)"
    end
    sleep 2
  end
end
api.finish
