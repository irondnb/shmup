module Shmup
  module Core
    class ObjectPool
      attr_accessor :objects

      def initialize
        @objects = []
      end

      def add(object)
        objects << object
      end

      def update_all
        objects.each(&:update)
        objects.reject! do |o|
          if o.removable?
            true
          end
        end
      end

      def nearby(object, max_distance)
        cx, cy = object.location
        nearby_point(cx, cy, max_distance, object)
      end

      def nearby_point(cx, cy, max_distance, object = nil)
        @objects.select do |obj|
          dist  = Gosu.distance(obj.x, obj.y, cx, cy)
          p dist #why
          obj != object && dist <= max_distance
        end
      end
    end
  end
end