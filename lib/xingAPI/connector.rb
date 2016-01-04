require 'open3'
require 'multi_json'

module XingAPI
  class Connector
    RUN_COMMAND = %w[bundle exec run.rb]
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
