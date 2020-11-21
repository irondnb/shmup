module Shmup
  module Core
    class GameObject
      attr_reader :x, :y, :components

      def initialize(object_pool, x, y)
        @x = x
        @y = y
        @components = []
        @object_pool = object_pool
        @object_pool.add(self)
      end

      def move(new_x, new_y)
        return if new_x == @x && new_y == @y

        @object_pool.tree_remove(self)
        @x = new_x
        @y = new_y
        @object_pool.tree_insert(self)
      end

      def update
        @components.each(&:update)
      end

      def draw
        @components.each(&:draw)
        Utils.mark_corners(box)
      end

      def effect?
        false
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

      def box_height
        @box_height ||= graphics.height
      end

      def box_width
        @box_width ||= graphics.width
      end

      def box
        if respond_to?(:graphics)
          w = box_width / 2
          h = box_height / 2
          [
            x - w, y - h,
            x + w, y - h,
            x + w, y + h,
            x - w, y + h
          ]
        else
          location
        end
      end

      def on_collision(object); end

      protected

      attr_reader :object_pool
    end
  end
end
