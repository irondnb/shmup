# frozen_string_literal: true

module Shmup
  module Entities
    module Particle
      class Physics < Core::Component

        attr_reader :object_pool

        def initialize(game_object, object_pool)
          super(game_object)
          @object_pool = object_pool
        end

        def update
          object.move(x + object.d_x, y + object.d_y + object_pool.world_speed)
          object.rotate
          object.decay
          object.mark_for_removal if object.dead?
        end
      end
    end
  end
end
