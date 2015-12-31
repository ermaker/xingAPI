ext_path = File.expand_path('../../ext/xingAPI', __FILE__)
ENV['PATH'] = "#{ext_path};#{ENV['PATH']}"

require "xingAPI/version"
require 'logger'

module XingAPI
  def logger
    @logger = Logger.new(STDOUT).tap do |logger|
      logger.level = Logger.const_get(
        (ENV['LOG'] || 'debug').upcase
      )
    end
  end
  module_function :logger
end
