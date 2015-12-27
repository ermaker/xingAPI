ext_path = File.expand_path('../../ext', __FILE__)
ENV['PATH'] = "#{ext_path};#{ENV['PATH']}"

require "xingAPI/version"
require 'logger'

module XingAPI
  def logger
    @logger = Logger.new(STDOUT)
  end
  module_function :logger
end
