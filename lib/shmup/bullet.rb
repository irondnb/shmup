module Shmup
  class Bullet < Core::GameObject
    attr_reader :source

    def initialize(object_pool, source)
      super(object_pool, source.x, source.y)
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/bullet.png'))
      @source = source
    end

    def update
      @y -= 25

      object_pool.nearby(self, 120).each do |obj|
        next if obj == source

        hit(obj) if obj.respond_to?(:health)
      end
    end

    def draw
      @graphics.draw(x, y, 2)
    end

    def hit(obj)
      obj.health.inflict_damage(10)
    end
  end
end
