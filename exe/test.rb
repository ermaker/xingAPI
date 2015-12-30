require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/api'

# XingAPI::API.new(ENV['IP'], ENV['PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2']) do |api|
api = XingAPI::API.new(ENV['IP'], ENV['PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2'])
if true
  if false
    result = api.tr_CSPAT00600(ENV['ACCOUNT'], ENV['ACCOUNT_PASS'], '114800', 1, :sell)
    ::XingAPI::logger.info { result[:message] }
  end

  if true
    3.times do
      result = api.tr_t1901('122630')
      ::XingAPI::logger.info do
        "#{result[:data][:hname].strip}: #{result[:data][:price]} (#{result[:data][:diff]}%)"
      end
      sleep 2
    end
  end
end
