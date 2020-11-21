# frozen_string_literal: true

module Shmup
  module Enemy
    class Ship < Core::GameObject
      attr_accessor :health, :graphics, :offset, :movement, :fire_motion, :definition

      def initialize(object_pool, definition)
        super(object_pool, definition.offset, -100)
        @definition = definition
        @graphics = Enemy.load_sprite(definition.sprite)
        @health = Health.new(self, definition.health)
        @movement = definition.movement
        @fire_motion = definition.fire_motion
        @offset = definition.offset
        @damage = 100 # definition.damage
      end

      def update
        super
        @movement.call(self, object_pool.world_speed)
        shoot if gun?
        mark_for_removal if @y > $window.height || dead?
      end

      def draw
        super
        @graphics.draw_rot(x, y, 1, ZOrder::ENEMY)
      end

      def gun?
        @gun ||= @fire_motion != Shmup::FireMotion::NONE
      end

      def shoot
        return unless can_shoot?

        @last_shoot = Gosu.milliseconds
        Bullet.new(object_pool, self, @fire_motion, @damage)
      end

      def can_shoot?
        Gosu.milliseconds > (@last_shoot || 0) + 500
      end

      def dead?
        health.dead?
      end

      def mark_for_removal
        super
        Explosion.new(object_pool, x, y) if dead?
      end
    end
  end
end
