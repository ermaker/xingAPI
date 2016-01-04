require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/api'
require 'mshard'

XingAPI::API.new(ENV['IP'], ENV['PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2']) do |api|
    MShard::MShard.new.set_safe(pushbullet: true, type: :note, title: "START: KODEX Inverse")
    loop do
      result = api.tr_t1901('114800')
      ::XingAPI::logger.info do
        "#{result[:data][:hname].strip}: #{result[:data][:price]} (#{result[:data][:diff]}%)"
      end
      price = result[:data][:price].to_i
      if MShard::MShard.new.get(:notify) != 'stop' && price < 8385 || price > 8450
        MShard::MShard.new.set_safe(pushbullet: true, type: :note, title: "#{price}: KODEX Inverse")
      end
      sleep 60
    end
end
