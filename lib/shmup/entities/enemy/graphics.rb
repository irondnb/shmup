# frozen_string_literal: true

module Shmup
  module Entities
    module Enemy
      class Graphics < Core::Component
        def initialize(game_object, sprite)
          super(game_object)
          @sprite = Gosu::Image.new(Utils.asset_path("/sprites/enemy/#{sprite}.png"), tileable: false)
        end

        def draw
          @sprite.draw_rot(x, y, ZOrder::PLAYER, 0)
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
