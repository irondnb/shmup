# frozen_string_literal: true

module Shmup
  module Entities
    class Bullet < Core::GameObject
      attr_reader :source, :vel_x, :vel_y, :graphics, :damage

      def initialize(object_pool, source, x, y, vel_x, vel_y,  damage)
        super(object_pool, x, y)
        @source = source
        @vel_x = vel_x
        @vel_y = vel_y
        @damage = damage

        @graphics = set_sprite
        sound.play if source.instance_of? Shmup::Entities::Player::Base #hack
      end

      def update
        new_x = x + vel_x
        new_y = y + vel_y
        @angle = Utils.angle_between(x, y, new_x, new_y)
        move(new_x, new_y)

        objects = object_pool.nearby(self, 100)
        objects.each do |obj|
          next if obj == source || obj.instance_of?(self.class) || obj.instance_of?(source.class)

          hit(obj) if Utils.point_in_poly(x, y, *obj.box)
        end

        mark_for_removal if y.negative? || x.negative? || y > $window.height || x > $window.width
      end

      def fire
        @fired_at = Gosu.milliseconds
      end

      def draw
        @graphics.draw_rot(x, y, ZOrder::BULLET, @angle)
      end

      def hit(obj)
        return unless obj.respond_to?(:health)

        obj.health.inflict_damage(damage, source)
        Hit.new(object_pool, x, y)
        mark_for_removal
      end

      def set_sprite
        case damage
        when 0..100
          Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_01.png'))
        when 100..300
          Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_02.png'))
        end
      end

      def sound
        @@sound ||= Gosu::Sample.new(Utils.asset_path('sounds/shoot_01.wav'))
      end
    end
  end
end
