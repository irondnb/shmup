# frozen_string_literal: true

%w[
  base
  graphics
  sound
].each { |filename| require "shmup/entities/explosion/#{filename}" }

module Shmup
  module Entities
    module Explosion
    end
  end
end
