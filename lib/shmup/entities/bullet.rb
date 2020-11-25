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
    end
  end
end
