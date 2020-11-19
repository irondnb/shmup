module Shmup
  module Core
    class Component
      attr_reader :object

      def initialize(game_object = nil)
        self.object = game_object
      end

      def update
        # override
      end

      def draw
        # override
      end

      protected

      def object=(obj)
        if obj
          self.object = obj
          obj.components << self
        end
      end

      def x
        object.x
      end

      def y
        object.y
      end
    end
  end
end