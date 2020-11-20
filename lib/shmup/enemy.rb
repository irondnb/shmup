module Shmup
  class Enemy < Core::GameObject
    attr_accessor :health

    def initialize(object_pool, definition)
      super(object_pool, definition.position_x, 0)
      @graphics = definition.sprite
      @y = @y - @graphics.height
      @health = 100
    end

    def update
      @y = @y + 10
      mark_for_removal if @y > $window.height || dead?
    end

    def draw
      @graphics.draw_rot(x, y, 1, 0)
      Gosu::Image.from_text(@health, 20).draw(x, y - 100, 1)
    end

    def dead?
      @health <= 0
    end
  end
end