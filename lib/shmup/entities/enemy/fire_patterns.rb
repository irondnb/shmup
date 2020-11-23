module Shmup
  module Entities
    module Enemy
      module FirePatterns
        DOWN = -> (object, world_speed) {
          object.shoot(object.x, object.y + world_speed, 300, 50)
        }

        CIRCLE = ->(object, world_speed) {
          bullets = 15
          theta = Math::PI * 2.0 / bullets
          bullets.times do |i|
            target_x = 10 * Math.cos(theta * i)
            target_y = 10 * Math.sin(theta * i) + world_speed
            object.shoot(target_x, target_y, 150, 300)
          end
        }
      end
    end
  end
end