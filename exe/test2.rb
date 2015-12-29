require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/xingAPI'
require 'xingAPI/api'
require 'xingAPI/data'

XingAPI::API.new(ENV['IP'], ENV['PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2']) do |api|
  if true
    api.tr_CSPAT00600(ENV['ACCOUNT'], ENV['ACCOUNT_PASS'], '114800', 1, :sell)
  end

  if false
    3.times do
      data = api.tr_t1901('122630')
      ::XingAPI::logger.info { "#{data[:hname].strip}: #{data[:price]} (#{data[:diff]}%)" }
      sleep 2
    end
  end
end
