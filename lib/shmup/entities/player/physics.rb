# frozen_string_literal: true

module Shmup
  module Entities
    module Player
      class Physics < Core::Component
        def initialize(game_object, object_pool)
          super(game_object)
          @object_pool = object_pool
        end

        def update
          @object_pool.nearby(object, 150).each do |obj|
            dist = Gosu.distance(object.x, object.y, obj.x, obj.y)
            object.on_collision(obj) if dist < 100
          end
        end

        def move_up
          object.move(object.x, object.y - object.velocity)
          object.move(object.x, min_height) if object.y < min_height
        end

        def move_down
          object.move(object.x, object.y + object.velocity)
          object.move(object.x, max_height) if object.y > max_height
        end

        def move_left
          object.move(object.x - object.velocity, object.y)
          object.move(min_width, object.y) if object.x < min_width
        end

        def move_right
          object.move(object.x + object.velocity, object.y)
          object.move(max_width, object.y) if object.x > max_width
        end

        private

        def width
          @width ||= object.graphics.width
        end

        def height
          @height ||= object.graphics.height
        end

        def max_height
          $window.height - min_height
        end

        def max_width
          $window.width - min_width
        end

        def min_height
          height / 2
        end

        def min_width
          width / 2
        end
      end
    end
  end
end
