# frozen_string_literal: true

module Shmup
  module Entities
    module Particle
      class Graphics < Core::Component
        def initialize(game_object, sprite)
          super(game_object)
          @sprite = sprite
        end

        def draw
          draw_layer(ZOrder::SHADOW, Gosu::Color.new((object.life * 128).floor, 0, 0, 0), x + 2, y + 2)
          draw_layer(ZOrder::SHAPE, Gosu::Color.new((object.life * 255).floor, 100, 100, 100))
          draw_layer(ZOrder::HIGHLIGHT, Gosu::Color.new((object.life * 20).floor, 255, 255, 255))
        end

        private

        def draw_layer(layer, color, x = nil, y = nil)
          @sprite.draw_rot(x || object.x, y || object.y, layer, object.angle, 0.5, 0.5, object.life, object.life, color, :default)
        end
      end
    end
  end
end
