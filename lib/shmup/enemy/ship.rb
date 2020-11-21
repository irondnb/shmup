module Shmup
  module Enemy
    class Ship < Core::GameObject
      attr_accessor :health, :graphics

      def initialize(object_pool, definition)
        super(object_pool, definition.offset, -100)
        @graphics = Enemy.load_sprite(definition.sprite)
        @health = Health.new(self, definition.health)
        @movement = definition.movement
      end

      def update
        @movement.call(self, object_pool.world_speed)
        mark_for_removal if @y > $window.height || dead?
      end

      def draw
        super
        @graphics.draw_rot(x, y, 1, ZOrder::ENEMY)
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
