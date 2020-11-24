# frozen_string_literal: true

module Shmup
  module Entities
    module Enemy
      class Base < Core::GameObject
        attr_reader :health, :graphics, :physics, :definition, :fired_at, :offset

        def initialize(object_pool, definition)
          super(object_pool, definition.offset, -100)
          @definition = definition
          @offset = definition.offset
          @graphics = Graphics.new(self, definition.sprite)
          @input = Input.new(self, object_pool, definition.movement, definition.fire_pattern, 500)
          @health = Components::Health.new(self, object_pool, definition.health, true)
        end

        def shoot(target_x, target_y, damage)
          @fired_at = Gosu.milliseconds
          Bullet.new(object_pool, self, x, y, target_x, target_y, damage).fire
        end

        def dead?
          health.dead?
        end

        def immune?
          false
        end
      end
    end
  end
end
