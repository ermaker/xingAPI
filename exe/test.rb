require 'dotenv'
Dotenv.load

require 'xingAPI'
require 'xingAPI/api'

require 'open3'
require 'multi_json'

module XingAPI
  class Connector
    RUN_COMMAND = %w[bundle exec ruby -Ilib exe\\run.rb]
    # RUN_COMMAND = %w[bundle exec run]
    def initialize
      @stdin, @stdout, @wait_thr = Open3.popen2(*RUN_COMMAND)
    end

    def run_(*args)
      @stdin.puts(MultiJson.dump(args))
    end

    def run(*args)
      run_(*args)
      MultiJson.load(@stdout.gets)
    end

    def method_missing(*args)
      run(*args)
    end

    def finish
      run_(:exit)
    ensure
      @stdin.close
      @stdout.close
    end
  end
end

module XingAPI
  @logger = Logger.new(STDOUT)
end

api = XingAPI::Connector.new
if true
  ::XingAPI::logger.info { "account: #{api.account(0)}" }
end
if false
  result = api.tr_CSPAT00600(ENV['ACCOUNT'], ENV['ACCOUNT_PASS'], '114800', 1, :sell)
  ::XingAPI::logger.info { result[:message] }
end
if true
  3.times do
    result = api.tr_t1901('122630')
    ::XingAPI::logger.info do
      "#{result['data']['hname'].strip}: #{result['data']['price']} (#{result['data']['diff']}%)"
    end
    sleep 2
  end
end
api.finish
