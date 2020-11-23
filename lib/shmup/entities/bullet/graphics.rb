# frozen_string_literal: true

module Shmup
  module Entities
    module Bullet
      class Graphics < Core::Component

        def initialize(game_object, damage)
          super(game_object)
          @sprite = sprite(damage)
        end

        def draw
          @sprite.draw_rot(x, y, ZOrder::BULLET, object.physics.angle)
        end

        private

        def sprite(damage)
          case damage
          when 0..100
            Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_01.png'))
          when 100..300
            Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_02.png'))
          end
        end
      end
    end
  end
end