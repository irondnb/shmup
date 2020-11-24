# frozen_string_literal: true

module Shmup
  module Entities
    module Bullet
      class Base < Core::GameObject
        attr_accessor :angle
        attr_reader :source, :vel_x, :vel_y, :graphics, :physics, :damage

        def initialize(object_pool, source, x, y, vel_x, vel_y, damage)
          super(object_pool, x, y)
          @source = source
          @vel_x = vel_x
          @vel_y = vel_y
          @damage = damage

          @graphics = Graphics.new(self, damage)
          @physics = Physics.new(self, object_pool)
          @sound = Sound.play
        end

        def fire
          @fired_at = Gosu.milliseconds
        end
      end
    end
  end
end
