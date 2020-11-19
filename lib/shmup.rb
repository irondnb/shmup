require 'gosu'
require 'logger'

%w(
  core
  player
  utils
).each { |filename| require "shmup/#{filename}" }

module Shmup
  class << self
    def start
      Core::Window.new.show
    rescue => e
      logger.fatal e.full_message
    end

    def logger
      @@logger ||= Logger.new(STDOUT)
    end
  end
end
