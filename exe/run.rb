require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/api'
require 'multi_json'

def to_scrub(value)
  case value
  when Array
    value.map { |v| to_scrub(v) }
  when Hash
    Hash[value.map { |key, value| [to_scrub(key), to_scrub(value)] }]
  when Symbol
    to_scrub(value.to_s).to_sym
  when String
    value.scrub
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
    args = MultiJson.load(gets, symbolize_keys: true)
    puts MultiJson.dump(to_scrub(api.send(*args)))
  end
end
