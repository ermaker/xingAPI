require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/api'
require 'multi_json'

def to_symbol(value)
  case value
  when Array
    value.map { |v| to_symbol(v) }
  when Hash
    Hash[value.map { |key, value| [key.to_sym, to_symbol(value)] }]
  else
    value
  end
end

STDIN.sync = true
STDOUT.sync = true

XingAPI::API.new(ENV['TRADE_IP'], ENV['TRADE_PORT'], ENV['ID'], ENV['PASS'], ENV['PASS2']) do |api|
  api.extend(Module.new do
    def exit
      Kernel.exit
    end
  end)
  loop do
  	args = to_symbol(MultiJson.load(gets))
    puts MultiJson.dump(api.send(*args))
  end
end