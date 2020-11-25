# frozen_string_literal: true

%w[
  base
  graphics
  physics
].each { |filename| require "shmup/entities/particle/#{filename}" }

module Shmup
  module Entities
    module Particle
    end
  end
end
