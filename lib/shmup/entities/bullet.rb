# frozen_string_literal: true

module Shmup
  module Entities
    class Bullet < Core::GameObject
      attr_reader :source, :graphics, :motion, :damage

      def initialize(object_pool, source, motion, damage)
        super(object_pool, source.x, source.y)
        @source = source
        @motion = motion
        @damage = damage
        @graphics = set_sprite
        sound.play if source.instance_of? Shmup::Entities::Player::Player #hack
      end

      def update
        motion.call(self, object_pool.world_speed)
        mark_for_removal if y.negative?
        objects = object_pool.nearby(self, 100)
        objects.each do |obj|
          next if obj == source || obj.instance_of?(self.class) || obj.instance_of?(source.class)

          hit(obj) if Utils.point_in_poly(x, y, *obj.box)
        end
      end

      def draw
        @graphics.draw_rot(x, y, 0, ZOrder::BULLET)
      end

      def hit(obj)
        return unless obj.respond_to?(:health)

        obj.health.inflict_damage(damage, source)
        Hit.new(object_pool, x, y)
        mark_for_removal
      end

      def set_sprite
        case damage
        when 0..500
          Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_01.png'))
        when 500..1000
          Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_02.png'))
        end
      end

      def sound
        @@sound ||= Gosu::Sample.new(Utils.asset_path('sounds/shoot_01.wav'))
      end
    end
  end
end
