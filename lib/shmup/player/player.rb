# frozen_string_literal: true

module Shmup
  module Player
    class Player < Core::GameObject
      attr_reader :graphics, :physics, :velocity, :health, :stats

      HEALTH = 500

      def initialize(object_pool)
        super(object_pool, *spawn_point)

        @graphics = Graphics.new(self)
        @physics = Physics.new(self, object_pool)
        @health = Health.new(self, object_pool, HEALTH, true)
        @input = Input.new(self)
        @stats = Stats.new

        @velocity = 10
        @fire_rate = 600
        @damage = 300
      end

      def shoot
        return unless can_shoot?

        @last_shoot = Gosu.milliseconds
        Bullet.new(object_pool, self, FireMotion::UP, @damage)
      end

      def can_shoot?
        Gosu.milliseconds > (@last_shoot || 0) + @fire_rate
      end

      def on_collision(object)
        health.inflict_damage(250, self) if object.instance_of? Shmup::Enemy::Enemy
      end

      def dead?
        health.dead?
      end

      private

      def spawn_point
        [$window.width / 2, $window.height - 200]
      end
    end
  end
end
