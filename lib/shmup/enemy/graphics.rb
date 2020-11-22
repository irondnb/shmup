module Shmup
  module Enemy
    class Graphics < Core::Component
      def initialize(game_object, definition)
        super(game_object)
        @sprite = Enemy.load_sprite(definition.sprite)
      end

      def draw
        @sprite.draw_rot(x, y, 1, ZOrder::ENEMY)
      end

      def width
        @sprite.width
      end

      def height
        @sprite.height
      end
    end
  end
end