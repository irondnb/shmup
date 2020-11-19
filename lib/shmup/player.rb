module Shmup
  class Player < Core::GameObject
    attr_accessor :graphics, :velocity

    def initialize(object_pool)
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/player_ship_blue.png'), tileable: false)
      super(object_pool, ($window.width - @graphics.width) / 2,  $window.height - @graphics.height - 200)

      @velocity = 10
    end

    def update
      p object_pool.nearby(self, 500).map(&:object_id)
      move_up    if Gosu::button_down?(Gosu::KbUp)
      move_left  if Gosu::button_down?(Gosu::KbLeft)
      move_right if Gosu::button_down?(Gosu::KbRight)
      move_down  if Gosu::button_down?(Gosu::KbDown)
      shoot      if Gosu::button_down?(Gosu::KbSpace)
    end

    def draw
      @graphics.draw_rot(x, y, 1, 0)
    end

    def move_up
      @y -= velocity
      @y = min_height if @y < min_height
    end

    def move_down
      @y += velocity
      @y = max_height if @y > max_height
    end

    def move_left
      @x -= velocity
      @x = min_width if @x < min_width
    end

    def move_right
      @x += velocity
      @x = max_width if @x > max_width
    end

    def shoot
      p :boom
    end

    private

    def width
      @width ||= graphics.width
    end

    def height
      @height ||= graphics.height
    end

    def max_height
      $window.height - min_height
    end

    def max_width
      $window.width - min_width
    end

    def min_height
      height / 2
    end

    def min_width
      width / 2
    end
  end
end
