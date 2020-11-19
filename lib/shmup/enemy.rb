module Shmup
  class Enemy < Core::GameObject
    def initialize(object_pool, definition)
      super(object_pool, definition.position_x, 0)
      @graphics = definition.sprite
      @y = @y - @graphics.height
    end

    def update
      @y = @y + 10
      mark_for_removal if @y > $window.height
    end

    def draw
      @graphics.draw_rot(x, y, 1, 0)
    end
  end
end