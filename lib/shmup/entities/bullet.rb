# frozen_string_literal: true

module Shmup
  module Entities
    class Bullet < Core::GameObject
      attr_reader :source, :target_x, :target_y, :graphics, :speed, :damage

      def initialize(object_pool, source, target_x, target_y, speed, damage)
        super(object_pool, source.x, source.y)
        @source = source
        @target_x = target_x
        @target_y = target_y
        @speed = speed
        @damage = damage

        @graphics = set_sprite
        sound.play if source.instance_of? Shmup::Entities::Player::Base #hack
      end

      def update
        mark_for_removal if y.negative? || x.negative? || y > $window.height || x > $window.width

        fly_speed = Utils.adjust_speed(speed)
        now = Gosu.milliseconds
        @last_update ||= @fired_at
        fly_distance = (now - @last_update) * 0.01 * fly_speed

        # new_x = x + target_x
        # new_y = y + target_y
        new_pos = point_at_distance(fly_distance)
        set_angle(*new_pos)
        move(*new_pos)

        objects = object_pool.nearby(self, 100)
        objects.each do |obj|
          next if obj == source || obj.instance_of?(self.class) || obj.instance_of?(source.class)

          hit(obj) if Utils.point_in_poly(x, y, *obj.box)
        end
      end

      # def update
      #   fly_speed = Utils.adjust_speed(object.speed)
      #   now = Gosu.milliseconds
      #   @last_update ||= object.fired_at
      #   fly_distance = (now - @last_update) * 0.001 * fly_speed
      #   object.move(*point_at_distance(fly_distance))
      #   @last_update = now
      #   check_hit
      #   object.explode if arrived?
      # end

      def fire
        @fired_at = Gosu.milliseconds
      end

      def trajectory_length
        Gosu.distance(target_x, target_y, x, y)
      end

      def point_at_distance(distance)
        # if distance > trajectory_length
        #   return [object.target_x, object.target_y]
        # end

        distance_factor = distance.to_f / trajectory_length
        p_x = x + target_x * distance_factor
        p_y = y + target_y * distance_factor
        [p_x, p_y]
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
        when 0..500
          Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_01.png'))
        when 500..1000
          Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_02.png'))
        end
      end

      def sound
        @@sound ||= Gosu::Sample.new(Utils.asset_path('sounds/shoot_01.wav'))
      end

      def set_angle(new_x, new_y)
        @angle = Utils.angle_between(x, y, new_x, new_y)
      end
    end
  end
end
