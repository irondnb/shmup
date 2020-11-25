# frozen_string_literal: true

%w[
  base
  graphics
  sound
].each { |filename| require "shmup/entities/hit/#{filename}" }

module Shmup
  module Entities
    module Hit
    end
  end
end
