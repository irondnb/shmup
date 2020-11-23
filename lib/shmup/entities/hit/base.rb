module Shmup
  module Entities
    module Hit
      class Base < Core::GameObject
        def initialize(object_pool, x, y)
          super(object_pool, x, y)
          @graphics = Graphics.new(self)
          @sound = Sound.play
        end
      end
    end
  end
end
