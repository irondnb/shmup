module Shmup
  class Player
    attr_reader :x, :y

    Z_INDEX = 1

    def initialize
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/player_ship_blue.png'), tileable: false)
      @x, @y = [ (Core::Window::WIDTH - @graphics.width) / 2,  (Core::Window::HEIGHT - @graphics.height) / 2]
    end

    def update
      move_up    if Gosu::button_down?(Gosu::KbUp)
      move_left  if Gosu::button_down?(Gosu::KbLeft)
      move_right if Gosu::button_down?(Gosu::KbRight)
      move_down  if Gosu::button_down?(Gosu::KbDown)
      shoot      if Gosu::button_down?(Gosu::KbSpace)
    end

    def draw
      @graphics.draw(x, y, Z_INDEX)
    end

    def move_up
      @y = @y - 10
      @y = 0 if @y < 0
    end

    def move_down
      @y = @y + 10
      @y = Core::Window::HEIGHT - @graphics.height if @y > Core::Window::HEIGHT - @graphics.height
    end

    def move_left
      @x = @x - 10
      @x = 0 if @x < 0
    end

    def move_right
      @x = @x + 10
      @x = Core::Window::WIDTH - @graphics.width if @x > Core::Window::WIDTH - @graphics.width
    end

    def shoot
      p :boom
    end
  end
end