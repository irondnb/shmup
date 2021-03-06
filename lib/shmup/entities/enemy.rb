# frozen_string_literal: true

%w[
  base
  bullet
  graphics
  input
  definition
  movement
  fire_patterns
].each { |filename| require "shmup/entities/enemy/#{filename}" }

module Shmup
  module Entities
    module Enemy
      class << self
        def spawn(*args)
          Base.new(*args)
        end

        def build(enemies)
          return [] unless enemies

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
