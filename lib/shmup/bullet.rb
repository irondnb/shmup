module Shmup
  class Bullet < Core::GameObject
    def initialize(object_pool, source)
      super(object_pool, source.x, source.y)
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/bullet.png'), tileable: false)
      @source = source
    end

    def update
      @y -= 25

      object_pool.nearby(self, 100).each do |obj|
        next if obj == @source # Don't hit source tank
        hit(obj) if obj.respond_to?(:health)
      end
    end

    def draw
      @graphics.draw(x + (@graphics.width / 2), y, 2)
    end

    def on_collision(obj)
      obj
    end


    def check_hit

    end

    def hit(obj)
      obj.health -= 10
    end
  end
end