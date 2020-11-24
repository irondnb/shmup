# frozen_string_literal: true

module Shmup
  module Entities
    module Hit
      class Base < Core::GameObject
        def initialize(object_pool, x, y)
          super(object_pool, x, y)
          @graphics = Graphics.new(self)
          @sound = Sound.play
        end

        def update
          move(x, y + object_pool.world_speed)
          super
        end

        def effect?
          true
        end

        def box
          [x, y]
        end
      end
    end
  end
end
