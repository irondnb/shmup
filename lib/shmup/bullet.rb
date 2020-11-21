module Shmup
  class Bullet < Core::GameObject
    attr_reader :source, :graphics, :motion, :damage

    def initialize(object_pool, source, motion, damage)
      super(object_pool, source.x, source.y)
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/bullet.png'))
      @source = source
      @motion = motion
      @damage = damage
    end

    def update
      motion.call(self, object_pool.world_speed)
      mark_for_removal if y.negative?
      objects = object_pool.nearby(self, 100)
      objects.each do |obj|
        next if obj == source || obj.instance_of?(Shmup::Bullet)

        hit(obj) if Utils.point_in_poly(x, y, *obj.box)
      end
    end

    def draw
      super
      @graphics.draw_rot(x, y, 0, ZOrder::BULLET)
    end

    def hit(obj)
      return unless obj.respond_to?(:health)
      obj.health.inflict_damage(damage)
      mark_for_removal
    end
  end
end
