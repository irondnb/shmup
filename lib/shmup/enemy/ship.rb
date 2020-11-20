module Shmup
  module Enemy
    class Ship < Core::GameObject
      attr_accessor :health, :graphics

      def initialize(object_pool, definition)
        super(object_pool, definition.offset, -100)
        @movement = definition.movement
        @graphics = Sprites[definition.sprite]
        @health = Health.new(self, 100)
      end

      def update
        @movement.call(self, object_pool.world_speed)
        mark_for_removal if @y > $window.height || dead?
      end

      def draw
        super
        @graphics.draw_rot(x, y, 1, 0)
      end

      def dead?
        health.dead?
      end
    end
  end
end
