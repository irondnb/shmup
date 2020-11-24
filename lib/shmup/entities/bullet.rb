# frozen_string_literal: true

%w[
  base
  graphics
  physics
  sound
].each { |filename| require "shmup/entities/bullet/#{filename}" }

module Shmup
  module Entities
    module Bullet
      class << self
        def new(*args)
          Base.new(*args)
        end
      end
    end
  end
end
