# frozen_string_literal: true

%w[
  base
  graphics
  sound
].each { |filename| require "shmup/entities/hit/#{filename}" }

module Shmup
  module Entities
    module Hit
      class << self
        def new(*args)
          Base.new(*args)
        end
      end
    end
  end
end
