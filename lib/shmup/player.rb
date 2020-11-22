# frozen_string_literal: true

%w[
  player
  graphics
  physics
  input
].each { |filename| require "shmup/player/#{filename}" }

module Shmup
  module Player
    class << self
      def new(object_pool)
        Player.new(object_pool)
      end
    end
  end
end
