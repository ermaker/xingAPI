require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/api'
require 'multi_json'

STDIN.sync = true
STDOUT.sync = true

XingAPI::API.new(ENV['TRADE_IP'], ENV['TRADE_PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2']) do |api|
  api.extend(Module.new do
    def exit
      Kernel.exit
    end
  end)
  loop do
    puts MultiJson.dump(api.send(*MultiJson.load(gets)))
  end
end