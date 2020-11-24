# frozen_string_literal: true

module Shmup
  module Entities
    module Enemy
      class Input < Core::Component
        attr_accessor :object_pool, :movement, :fire_pattern, :fire_delay

        def initialize(game_object, object_pool, movement, fire_pattern, fire_delay)
          super(game_object)
          @object_pool = object_pool
          @movement = movement
          @fire_pattern = fire_pattern
          @fire_delay = fire_delay
        end

        def update
          movement.call(object, object_pool.world_speed)
          fire_pattern.call(object, object_pool.world_speed) if can_shoot?
          object.mark_for_removal if behind_screen?
        end

        private

        def can_shoot?
          Gosu.milliseconds > fired_at + fire_delay
        end

        def fired_at
          (object.fired_at || 0)
        end

        def behind_screen?
          object.y > $window.height
        end
      end
    end
  end
end
