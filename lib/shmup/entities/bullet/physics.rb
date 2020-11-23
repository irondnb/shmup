# frozen_string_literal: true

module Shmup
  module Entities
    module Bullet
      class Physics < Core::Component

        attr_reader :object_pool, :angle

        def initialize(game_object, object_pool)
          super(game_object)
          @object_pool = object_pool
        end

        def update
          position = target_position
          @angle = angle_between(*position)
          object.move(*position)

          object_pool.nearby(object, 100).each do |obj|
            next if obj == object.source || obj.instance_of?(object.class) || obj.instance_of?(object.source.class)

            hit(obj) if Utils.point_in_poly(x, y, *obj.box)
          end

          object.mark_for_removal if outside_screen?
        end

        private

        def target_position
          new_x = object.x + object.vel_x
          new_y = object.y + object.vel_y
          [new_x, new_y]
        end

        def angle_between(new_x, new_y)
          Utils.angle_between(object.x, object.y, new_x, new_y)
        end

        def outside_screen?
          object.y.negative? || object.x.negative? || object.y > $window.height || object.x > $window.width
        end

        def hit(obj)
          return unless obj.respond_to?(:health)

          obj.health.inflict_damage(object.damage, object.source)
          Hit.new(object_pool, x, y)
          object.mark_for_removal
        end
      end
    end
  end
end