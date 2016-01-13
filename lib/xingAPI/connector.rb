require 'multi_json'
require 'open3'
require 'timeout'

module XingAPI
  class Connector
    def initialize
      open
    end

    RUN_COMMAND = %w[bundle exec run.rb]

    def open
      @stdin, @stdout, @wait = Open3.popen2(*RUN_COMMAND)
    end

    def reopen
      finish_
      open
    end

    def run_(*args)
      @stdin.puts(MultiJson.dump(args))
    end

    def run(*args)
      run_(*args)
      retval = Timeout.timeout(10) { @stdout.gets }
      MultiJson.load(retval)
    rescue Timeout::Error, Errno::EPIPE => e
      ::XingAPI::logger.warn { "#{e.class} (#{e.message}): #{args}" }
      reopen
      retry
    end

    def method_missing(*args)
      run(*args)
    end

    def finish_
      @wait.terminate rescue nil
      @stdin.close rescue nil
      @stdout.close rescue nil
    end

    def finish
      run_(:exit)
    ensure
      finish_
    end
  end
end
