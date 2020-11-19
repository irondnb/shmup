require 'gosu'
require 'logger'

%w(
  core
  states
  player
  enemy
  enemy_definition
  background
  utils
).each { |filename| require "shmup/#{filename}" }

module Shmup
  class << self
    def start
      $window = Core::Window.new
      States::GameState.switch(States::PlayState.new)
      $window.show
    rescue => e
      logger.fatal e.full_message
    end

    def logger
      @@logger ||= Logger.new(STDOUT)
    end
  end
end
