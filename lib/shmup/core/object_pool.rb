module Shmup
  module Core
    class ObjectPool
      attr_accessor :objects

      def initialize
        @objects = []
      end

      def add(object)
        @objects << object
      end

      def update_all
        @objects.each(&:update)
        @objects.reject! do |o|
          if o.removable?
            true
          end
        end
      end
    end
  end
end