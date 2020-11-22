# frozen_string_literal: true

%w[
  definition
  movement
  enemy
  graphics
  physics
].each { |filename| require "shmup/entities/enemy/#{filename}" }

module Shmup
  module Entities
    module Enemy
      class << self
        def spawn(object_pool, definition)
          Enemy.new(object_pool, definition)
        end

        def build(enemies)
          enemies.map do |enemy|
            Definition.new(*enemy.values)
          end
        end

        def build_boss(boss)
          return unless boss

          Definition.new(*boss.values)
        end
      end
    end
  end
end
