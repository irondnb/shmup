module Shmup
  module Entities
    module Enemy
      module FirePatterns
        NONE = -> (object, world_speed) { }

        DOWN = -> (object, world_speed) {
          object.shoot(0, world_speed * 2, 50)
        }

        CIRCLE = ->(object, world_speed) {
          BASE_CIRCLE.call(object, world_speed, 15, 2.0)
        }

        BASE_CIRCLE = ->(object, world_speed, bullets, range) {
          theta = Math::PI * range / bullets
          bullets.times do |i|
            vel_x = 10 * Math.cos(theta * i)
            vel_y = 10 * Math.sin(theta * i )
            object.shoot(vel_x * 0.75, vel_y * 0.75, 300)
          end
        }
      end
    end
  end
end