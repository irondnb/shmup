# frozen_string_literal: true

module Shmup
  module Entities
    module Player
      class Player < Core::GameObject
        attr_reader :graphics, :physics, :velocity, :health, :stats, :lives

        HEALTH = 500
        PROTECTION_TIME = 3000

        def initialize(object_pool)
          super(object_pool, *spawn_point)

          @graphics = Graphics.new(self)
          @physics = Physics.new(self, object_pool)
          @health = Health.new(self, object_pool, HEALTH, true)
          @input = Input.new(self)
          @stats = Stats.new

          @lives = 3
          @velocity = 10
          @fire_rate = 300
          # @fire_pattern =
          @damage = 300
          set_spawn_time
        end

        def shoot
          return unless can_shoot?

          @last_shoot = Gosu.milliseconds
          # @fire_pattern.call()
          # Bullet.new(object_pool, self, FireMotion::UP, @damage)
        end

        def can_shoot?
          Gosu.milliseconds > (@last_shoot || 0) + @fire_rate
        end

        def on_collision(object)
          health.inflict_damage(250, self) if object.instance_of? Shmup::Entities::Enemy::Enemy
        end

        def dead?
          @lives < 1
        end

        def immune?
          Gosu.milliseconds < @spawn_time + PROTECTION_TIME
        end

        def die
          @lives -= 1
          respawn
        end

        def respawn
          move(*spawn_point)
          health.restore
          set_spawn_time
        end

        private

        def set_spawn_time
          @spawn_time = Gosu.milliseconds
        end

        def spawn_point
          [$window.width / 2, $window.height - 200]
        end
      end
    end
  end
end
