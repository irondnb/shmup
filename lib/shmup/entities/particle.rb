module Shmup
  module Entities
    class Particle < Core::GameObject
      attr_reader :d_x, :d_y, :graphics, :angle, :speed, :decay, :life

      def initialize(object_pool, x, y, sprite, angle, speed, decay)
        super(object_pool, x, y)

        @graphics = sprite
        @angle =  90 - angle
        @speed = speed
        @decay = decay
        @d_x = Gosu.offset_x(@angle, @speed)
        @d_y = Gosu.offset_y(@angle, @speed)
        @life = 1.25
      end


      def update
        move(x + d_x, y + d_y)
        @angle += (speed / 2)
        @life -= decay
        mark_for_removal if dead?
      end

      def draw
        draw_layer(ZOrder::SHADOW, Gosu::Color.new((life * 128).floor,0,0,0), x + 2, y + 2)
        draw_layer(ZOrder::SHAPE, Gosu::Color.new((life * 255).floor, 100,100,100))
        draw_layer(ZOrder::HIGHLIGHT, Gosu::Color.new((life * 20).floor,255,255,255))
      end

      private

      def dead?
        life <= 0
      end

      def draw_layer(layer, color, x = nil, y = nil)
        @graphics.draw_rot(x || @x, y || @y, layer, angle, 0.5, 0.5, life, life, color, :default)
      end
    end
  end
end