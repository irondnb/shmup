module Shmup
  module Core
    class GameObject
      attr_reader :x, :y, :location, :components

      def initialize(object_pool, x, y)
        @x, @y = x, y
        @location = [x, y]
        @components = []
        @object_pool = object_pool
        @object_pool.add(self)
      end

      def update
        @components.each(&:update)
      end

      def draw
        @components.each(&:draw)
      end

      def removable?
        @removable
      end

      def mark_for_removal
        @removable = true
      end

      protected

      def object_pool
        @object_pool
      end
    end
  end
end