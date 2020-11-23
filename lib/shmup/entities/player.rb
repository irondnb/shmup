# frozen_string_literal: true

%w[
  base
  health
  graphics
  physics
  input
].each { |filename| require "shmup/entities/player/#{filename}" }

module Shmup
  module Entities
    module Player
      class << self
        def new(*args)
          Base.new(*args)
        end
      end
    end
  end
end
