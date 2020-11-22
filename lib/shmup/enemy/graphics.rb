# frozen_string_literal: true

module Shmup
  module Enemy
    class Graphics < Core::Component
      def initialize(game_object, definition)
        super(game_object)
        @sprite = Gosu::Image.new(Utils.asset_path("/sprites/enemy/#{definition.sprite}.png"), tileable: false)
      end

      def draw
        @sprite.draw_rot(x, y, 1, ZOrder::PLAYER)
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
