# frozen_string_literal: true

require 'gosu'
require 'logger'

%w[
  core
  states
  entities
  misc
].each { |filename| require "shmup/#{filename}" }

module Shmup
  class << self
    def start
      $window = Core::Window.new
      States::GameState.switch(States::PlayState.new)
      $window.show
    rescue StandardError => e
      logger.fatal e.class
      logger.fatal e.full_message
    end

    def logger
      @@logger ||= Logger.new($stdout)
    end
  end
end
