# frozen_string_literal: true

%w[
  base
  graphics
  sound
].each { |filename| require "shmup/entities/explosion/#{filename}" }

module Shmup
  module Entities
    module Explosion
      class << self
        def new(*args)
          Base.new(*args)
        end
      end
    end
  end
end
