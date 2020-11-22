# frozen_string_literal: true

%w[
  background
  bullet
  player
  enemy
  effect
  explosion
  hit
  health
  explosion
].each { |filename| require "shmup/entities/#{filename}" }

module Shmup
  module Entities
  end
end
