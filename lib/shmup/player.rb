module Shmup
  class Player < Core::GameObject
    attr_accessor :graphics, :velocity, :health

    def initialize(object_pool)
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/player_ship_blue.png'), tileable: false)
      super(object_pool, *spawn_point)
      @velocity = 10
      @health = Health.new(self, 500)
      @fire_rate = 600
      @damage = 300
    end

    def update
      super
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
      super
      @graphics.draw_rot(x, y, 1, ZOrder::PLAYER)
    end

    def move_up
      move(x, @y -= velocity)
      move(x, min_height) if @y < min_height
    end

    def move_down
      move(x, @y += velocity)
      move(x, max_height) if @y > max_height
    end

    def move_left
      move(@x -= velocity, y)
      move(min_width, y) if @x < min_width
    end

    def move_right
      move(@x += velocity, y)
      move(max_width, y) if @x > max_width
    end

    def shoot
      return unless can_shoot?

      @last_shoot = Gosu.milliseconds
      Bullet.new(object_pool, self, FireMotion::UP, @damage)
    end

    def can_shoot?
      Gosu.milliseconds > (@last_shoot || 0) + @fire_rate
    end

    def on_collision(object)
      #health.inflict_damage(500) if object.instance_of? Shmup::Enemy::Ship
    end

    def dead?
      health.dead?
    end

    private

    def spawn_point
      [$window.width  / 2,  $window.height - 200]
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
