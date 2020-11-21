# frozen_string_literal: true

module Shmup
  module Enemy
    module Movement
      NONE = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.1) }
      SLOW = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.25) }
      FAST = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.5) }

      SLOW_UP = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 0.5) }
      SOUTH_EAST = ->(object, world_speed) { object.move(object.x + world_speed * 0.75, object.y + world_speed * 1.25) }
      SOUTH_WEST = ->(object, world_speed) { object.move(object.x - world_speed * 0.75, object.y + world_speed * 1.25) }
      SIN = lambda { |object, world_speed|
        new_y = object.y + world_speed
        new_x = 200 * Math.sin(0.1 * new_y / 10) + object.offset
        object.move(new_x, new_y)
      }

      COS = lambda { |object, world_speed|
        new_y = object.y + world_speed
        new_x = 200 * Math.cos(0.1 * new_y / 10) + object.offset
        object.move(new_x, new_y)
      }

      TEST = lambda { |object, world_speed|
        new_x = object.x + world_speed
        tan = Math.tan(0.001 * Gosu.milliseconds)
        tan3 = tan * tan * tan
        new_y = new_x + object.offset * tan3
        object.move(new_x, new_y)
      }
    end
  end
end
