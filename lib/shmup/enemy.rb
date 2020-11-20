module Shmup
  class Enemy < Core::GameObject
    attr_accessor :health

    def initialize(object_pool, definition)
      @graphics = definition.sprite
      super(object_pool, definition.offset, -@graphics.height)
      @health = 100
    end

    def update
      @y += 10
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