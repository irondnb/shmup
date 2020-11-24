# frozen_string_literal: true

module Shmup
  module Entities
    module Particle
      class Base < Core::GameObject
        attr_reader :d_x, :d_y, :graphics, :angle, :speed, :decay_speed, :life

        def initialize(object_pool, x, y, sprite, angle, speed, decay_speed)
          super(object_pool, x, y)

          @graphics = Graphics.new(self, sprite)
          @physics = Physics.new(self)
          @angle = 90 - angle
          @speed = speed
          @decay_speed = decay_speed
          @d_x = Gosu.offset_x(@angle, @speed)
          @d_y = Gosu.offset_y(@angle, @speed)
          @life = 1.25
        end

        def box
          location
        end

        def dead?
          life <= 0
        end

        def decay
          @life -= decay_speed
        end

        def rotate
          @angle += (speed / 2)
        end
      end
    end
  end
end
