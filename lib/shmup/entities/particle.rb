# frozen_string_literal: true

%w[
  base
  graphics
  physics
].each { |filename| require "shmup/entities/particle/#{filename}" }

module Shmup
  module Entities
    module Particle
      class << self
        def new(*args)
          Base.new(*args)
        end
      end
    end
  end
end
