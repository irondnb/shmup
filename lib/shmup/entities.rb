# frozen_string_literal: true

%w[
  background
  bullet
  health
  player
  enemy
  effect
  explosion
  hit
  explosion
].each { |filename| require "shmup/entities/#{filename}" }

module Shmup
  module Entities
  end
end
