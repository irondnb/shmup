# frozen_string_literal: true

%w[
  background
  bullet
  health
  player
  enemy
  effect
  explosion
  particle_emitter
  particle
  hit
  explosion
].each { |filename| require "shmup/entities/#{filename}" }

module Shmup
  module Entities
  end
end
