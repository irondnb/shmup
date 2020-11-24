# frozen_string_literal: true

module Shmup
  module Entities
    module Player
      class Graphics < Core::Component
        def initialize(game_object)
          super(game_object)
          @sprite = Gosu::Image.new(Utils.asset_path('/sprites/player_ship_blue.png'), tileable: false)
        end

        def draw
          @sprite.draw_rot(x, y, ZOrder::PLAYER, 0)
          @sprite.draw_rot(x + 10, y + 35, ZOrder::SHADOW, 0, 0.5, 0.5, 0.85, 0.85, Gosu::Color.new(24, 0, 0, 0))
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
end
