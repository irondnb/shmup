# frozen_string_literal: true

module Shmup
  module Entities
    module Enemy
      Definition = Struct.new(:spawn_time, :sprite, :offset, :movement, :fire_pattern, :health) do
        def initialize(*args)
          super(*args)
          self.spawn_time = spawn_time + Gosu.milliseconds
          self.offset = offset * $window.width
          self.movement = set_movement(movement)
          self.fire_pattern = set_fire_pattern(fire_pattern)
        end

        def set_movement(value)
          eval "Movement::#{value.upcase}"
        rescue NameError => e
          Movement::NONE
        end

        def set_fire_pattern(value)
          eval "FirePatterns::#{value.upcase}"
        rescue NameError => e
          FirePatterns::NONE
        end
      end
    end
  end
end
