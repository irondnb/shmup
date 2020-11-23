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
          @sprite.draw_rot(x, y, ZOrder::ENEMY, 0)
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
