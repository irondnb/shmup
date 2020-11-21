module Shmup
  class Bullet < Core::GameObject
    attr_reader :source, :graphics, :motion

    def initialize(object_pool, source, motion)
      super(object_pool, source.x, source.y)
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/bullet.png'))
      @source = source
      @motion = motion
    end

    def update
      motion.call(self, object_pool.world_speed)
      object_pool.nearby(self, 120).each do |obj|
        next if obj == source

        hit(obj) if obj.respond_to?(:health) #&& Utils.point_in_poly(x, y, *obj.box)
      end
    end

    def draw
      super
      @graphics.draw_rot(x, y, 0, ZOrder::BULLET)
    end

    def hit(obj)
      obj.health.inflict_damage(10)
    end
  end
end
