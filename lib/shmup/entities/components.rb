# frozen_string_literal: true

%w[
  health
  particle_emitter
].each { |filename| require "shmup/entities/components/#{filename}" }

module Shmup
  module Entities
  end
end
