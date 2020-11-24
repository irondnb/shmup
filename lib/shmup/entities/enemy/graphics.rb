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
          @sprite.draw_rot(x, y, ZOrder::ENEMY, 0)
          @sprite.draw_rot(x + 20, y + 30, ZOrder::SHADOW, 0, 0.5, 0.5, 0.85, 0.85, Gosu::Color.new(24, 0, 0, 0))
        end

        def width
          @width ||= @sprite.width
        end

        def height
          @height ||= @sprite.height
        end
      end
    end
  end
end
