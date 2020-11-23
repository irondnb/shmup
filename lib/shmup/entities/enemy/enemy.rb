# frozen_string_literal: true

module Shmup
  module Entities
    module Enemy
      class Enemy < Core::GameObject
        attr_reader :health, :graphics, :physics, :definition

        def initialize(object_pool, definition)
          super(object_pool, definition.offset, -100)
          @definition = definition
          @graphics = Graphics.new(self, definition)
          @physics = Physics.new(self, object_pool, definition)
          @health = Health.new(self, object_pool, definition.health, true)
          @fire_motion = definition.fire_motion
          @damage = 1000 # definition.damage
        end

        def after_update
          shoot
          destroy if behind_screen?
        end

        def offset
          physics.offset
        end

        def shoot
          return unless can_shoot?

          @last_shoot = Gosu.milliseconds
          Bullet.new(object_pool, self, @fire_motion, @damage)
        end

        def dead?
          health.dead?
        end

        def immune?
          false
        end

        private

        def can_shoot?
          @fire_motion != Shmup::FireMotion::NONE && Gosu.milliseconds > (@last_shoot || 0) + 500
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
