# frozen_string_literal: true

%w[
  components
  animation
  background
  player
  bullet
  enemy
  explosion
  particle
  hit
].each { |filename| require "shmup/entities/#{filename}" }

module Shmup
  # Player = Entities::Player::Base
  # Enemy = Entities::Enemy::Base
  # Bullet = Entities::Enemy::Bullet
  # Explosion = Entities::Enemy::Explosion
  # Hit = Entities::Enemy::Hit
  # Hit = Entities::Enemy::Hit

  module Entities
  end
end
