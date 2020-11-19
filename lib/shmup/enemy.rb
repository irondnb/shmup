module Shmup
  class Enemy < Core::GameObject
    def initialize(object_pool, definition)
      super(object_pool, rand($window.width), 0)
      @graphics = definition.sprite
    end

    def update
      @y = @y + 8
    end

    def draw
      @graphics.draw(x, y, 1)
    end
  end
end