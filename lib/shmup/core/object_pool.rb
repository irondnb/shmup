module Shmup
  module Core
    class ObjectPool
      attr_accessor :objects, :background, :world_speed

      def initialize
        @objects = []
        boundary = AxisAlignedBoundingBox.new([$window.width / 2, $window.height / 2], [$window.width, $window.height])
        @tree = Quadtree.new(boundary)
      end

      def add(object)
        objects << object
        @tree.insert(object)
      end

      def tree_remove(object)
        @tree.remove(object)
      end

      def tree_insert(object)
        @tree.insert(object)
      end

      def update_all
        background.update
        objects.each(&:update)
        objects.reject! do |o|
          true if o.removable?
        end
      end

      def nearby_point(cx, cy, max_distance, object = nil)
        hx = cx + max_distance
        hy = cy + max_distance
        results = query_range(AxisAlignedBoundingBox.new([cx, cy], [hx, hy]))

        results.select do |obj|
          obj != object && Gosu.distance(obj.x, obj.y, cx, cy) <= max_distance
        end
      end

      def nearby(object, max_distance)
        cx, cy = object.location
        nearby_point(cx, cy, max_distance, object)
      end

      def query_range(box)
        @tree.query_range(box)
      end
    end
  end
end
