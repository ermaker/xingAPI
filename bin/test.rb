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
if true
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
