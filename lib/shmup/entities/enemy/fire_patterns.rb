# frozen_string_literal: true

module Shmup
  module Entities
    module Enemy
      module FirePatterns
        NONE = ->(object, world_speed) {}

        DOWN = lambda { |object, world_speed|
          object.shoot(0, world_speed * 2, 50)
        }

        TRIPLE = lambda { |object, world_speed|
          object.shoot(-3, world_speed * 2, 50)
          object.shoot(0, world_speed * 3, 150)
          object.shoot(3, world_speed * 2, 50)
        }


        CIRCLE = lambda { |object, world_speed|
          BASE_CIRCLE.call(object, world_speed, 32, 2.0)
        }

        BASE_CIRCLE = lambda { |object, _world_speed, bullets, range|
          theta = Math::PI * range / bullets
          bullets.times do |i|
            vel_x = 10 * Math.cos(theta * i)
            vel_y = 10 * Math.sin(theta * i)
            object.shoot(vel_x * 0.75, vel_y * 0.75, i.odd? ? 100 : 300)
          end
        }
      end
    end
  end
end
