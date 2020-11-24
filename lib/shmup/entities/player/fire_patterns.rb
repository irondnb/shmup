# frozen_string_literal: true

module Shmup
  module Entities
    module Player
      module FirePatterns
        SINGLE = lambda { |object, world_speed|
          object.fire(0, world_speed * -4, 50)
        }

        DOUBLE = lambda { |object, world_speed|
          object.fire(-2, world_speed * -4, 50)
          object.fire(2, world_speed * -4, 50)
        }

        TRIPLE = lambda { |object, world_speed|
          object.fire(-3, world_speed * -4, 50)
          object.fire(0, world_speed * -4, 150)
          object.fire(3, world_speed * -4, 50)
        }

        CIRCLE = lambda { |object, world_speed|
          bullets = 8
          theta = Math::PI * 2.0 / bullets
          bullets.times do |i|
            target_x = 10 * Math.cos(theta * i)
            target_y = 10 * Math.sin(theta * i) - world_speed
            object.fire(target_x, target_y, 50)
          end
        }
      end
    end
  end
end
