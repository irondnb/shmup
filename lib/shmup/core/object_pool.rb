module Shmup
  module Core
    class ObjectPool
      attr_accessor :objects, :background, :world_speed

      def initialize
        @objects = []
      end

      def add(object)
        objects << object
      end

      def update_all
        background.update
        objects.each(&:update)
        objects.reject! do |o|
          true if o.removable?
        end
      end

      def nearby(object, max_distance)
        cx, cy = object.location
        nearby_point(cx, cy, max_distance, object)
      end

      def nearby_point(cx, cy, max_distance, object = nil)
        @objects.select do |obj|
          obj != object && Gosu.distance(obj.x, obj.y, cx, cy) <= max_distance
        end
      end
    end
  end
end
