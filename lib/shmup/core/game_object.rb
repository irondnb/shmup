module Shmup
  module Core
    class GameObject
      attr_reader :x, :y, :components

      def initialize(object_pool, x, y)
        move(x, y)
        @components = []
        @object_pool = object_pool
        @object_pool.add(self)
      end

      def move(new_x, new_y)
        @x, @y = new_x, new_y
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

      def location
        [x, y]
      end

      def on_collision(object); end

      protected

      attr_reader :object_pool
    end
  end
end
