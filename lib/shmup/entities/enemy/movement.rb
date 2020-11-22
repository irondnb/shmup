# frozen_string_literal: true

module Shmup
  module Entities
    module Enemy
      module Movement
        NONE = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.1) }
        SLOW = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.25) }
        FAST = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 2) }

        SLOW_UP = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 0.5) }
        RIGHT = ->(object, world_speed) { object.move(object.x + world_speed * 0.75, object.y + world_speed * 1.25) }
        LEFT = ->(object, world_speed) { object.move(object.x - world_speed * 0.75, object.y + world_speed * 1.25) }
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

        BOSS = lambda { |object, world_speed|
          FAST.call(object, world_speed) if object.y < $window.height / 4
        }
      end
    end
  end
end
