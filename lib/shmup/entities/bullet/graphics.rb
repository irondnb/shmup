# frozen_string_literal: true

module Shmup
  module Entities
    module Bullet
      class Graphics < Core::Component
        def initialize(game_object, sprite)
          super(game_object)
          @sprite = sprite
        end

        def draw
          @sprite.draw_rot(x, y, ZOrder::BULLET, object.physics.angle)
        end

        def width
          @widht ||= @sprite.width
        end

        def height
          @height ||= @sprite.width
        end
      end
    end
  end
end
