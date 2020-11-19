module Shmup
  class Player
    attr_reader :x, :y

    def initialize(window)
      @window = window
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/player_ship_blue.png'), tileable: false)
      @x, @y = [ (@window.width - @graphics.width) / 2,  (@window.height - @graphics.height) / 2]
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
    end

    def move_up
      @y = @y - 10
      @y = 0 if @y < 0
    end

    def move_down
      @y = @y + 10
      if @y > @window.height - @graphics.height
        @y = @window.height - @graphics.height
      end
    end

    def move_left
      @x = @x - 10
      @x = 0 if @x < 0
    end

    def move_right
      @x = @x + 10
      if @x > @window.width - @graphics.width
        @x = @window.width - @graphics.width
      end
    end

    def shoot
      p :boom
    end
  end
end