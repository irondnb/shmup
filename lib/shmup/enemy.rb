module Shmup
  class Enemy
    def initialize
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/enemy/spaceShips_001.png.png'), tileable: false)
    end

    def update
      move_up    if Gosu::button_down?(Gosu::KbUp)
      move_left  if Gosu::button_down?(Gosu::KbLeft)
      move_right if Gosu::button_down?(Gosu::KbRight)
      move_down  if Gosu::button_down?(Gosu::KbDown)
      shoot      if Gosu::button_down?(Gosu::KbSpace)
    end

    def draw
      @graphics.draw(x, y, 1)

      @y = @y + 10
      if @y > @window.height - @graphics.height
        @y = @window.height - @graphics.height
      end
    end
  end
end