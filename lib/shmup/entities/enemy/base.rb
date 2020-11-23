# frozen_string_literal: true

module Shmup
  module Entities
    module Enemy
      class Base < Core::GameObject
        attr_reader :health, :graphics, :physics, :definition

        def initialize(object_pool, definition)
          super(object_pool, definition.offset, -100)
          @definition = definition
          @graphics = Graphics.new(self, definition)
          @physics = Physics.new(self, object_pool, definition)
          @health = Components::Health.new(self, object_pool, definition.health, true)
          @fire_pattern = definition.fire_motion
          @damage = 1000 # definition.damage
        end

        def after_update
          @fire_pattern.call(self, object_pool.world_speed) if can_shoot?
          destroy if behind_screen?
        end

        def offset
          physics.offset
        end

        def shoot(target_x, target_y, speed, damage)
          @fired_at = Gosu.milliseconds
          Bullet.new(object_pool, self, target_x, target_y, speed, damage).fire#(speed) #todo
        end

        def dead?
          health.dead?
        end

        def immune?
          false
        end

        private

        def can_shoot?
          @fire_pattern != Shmup::FireMotion::NONE && Gosu.milliseconds > (@fired_at || 0) + 500
        end

        def destroy
          mark_for_removal
        end

        def behind_screen?
          y > $window.height
        end
      end
    end
  end
end
