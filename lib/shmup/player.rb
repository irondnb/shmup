module Shmup
  class Player < Core::GameObject
    attr_accessor :graphics, :velocity, :health

    def initialize(object_pool)
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/player_ship_blue.png'), tileable: false)
      super(object_pool, *spawn_point)
      @velocity = 10
      @health = 500
      @fire_rate = 400

    end

    def update
      move_up    if Gosu::button_down?(Gosu::KbUp)
      move_left  if Gosu::button_down?(Gosu::KbLeft)
      move_right if Gosu::button_down?(Gosu::KbRight)
      move_down  if Gosu::button_down?(Gosu::KbDown)
      shoot      if Gosu::button_down?(Gosu::KbSpace)

      object_pool.nearby(self, 150).each do |obj|
        dist = Gosu.distance(x, y, obj.x, obj.y)
        on_collision(obj) if dist < 100
      end
    end

    def draw
      @graphics.draw_rot(x, y, 1, 0)
      Gosu::Image.from_text(@health, 80).draw(100, 100, 1)
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
      if can_shoot?
        @last_shoot = Gosu.milliseconds
        Bullet.new(object_pool, self)
      end
    end

    def can_shoot?
      Gosu.milliseconds > (@last_shoot || 0) + @fire_rate
    end

    def on_collision(object)
      if object.class == Shmup::Enemy::Ship
        @health -= 500
      end
    end

    def alive?
      health > 0
    end

    private

    def spawn_point
      [($window.width - @graphics.width) / 2,  $window.height - @graphics.height - 200]
    end

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
