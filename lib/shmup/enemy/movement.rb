module Shmup
  module Enemy
    module Movement
      NONE = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.1) }
      SLOW = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.25) }
      FAST = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.5) }

      SLOW_UP = ->(object, world_speed) { object.move(object.x, object.y + world_speed  * 0.5)}
      SOUTH_EAST = ->(object, world_speed) { object.move(object.x + world_speed * 0.75, object.y + world_speed * 1.25) }
      SOUTH_WEST = ->(object, world_speed) { object.move(object.x - world_speed * 0.75, object.y + world_speed * 1.25) }
      SINUS = lambda { |object, world_speed|
        new_x = object.offset + (200 * Math.sin(Gosu.milliseconds * 0.1 * Math::PI / 180))
        object.move(new_x, object.y + world_speed * 0.5)
      }

      TEST = lambda { |object, world_speed|
        new_x = object.offset + (200 * Math.sin(Gosu.milliseconds * 0.1 * Math::PI / 180))
        object.move(new_x, object.y + world_speed * 0.5)
      }
    end
  end
end
