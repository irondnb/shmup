# frozen_string_literal: true

module Shmup
  module Entities
    class Health < Core::Component
      attr_accessor :health

      def initialize(object, object_pool, health, explodes)
        super(object)
        @object_pool = object_pool
        @health, @initial_health = health
        @health_updated = true
        @explodes = explodes
      end

      def dead?
        @health < 1
      end

      def restore
        @health = @initial_health
      end

      def update
        update_image
      end

      def inflict_damage(amount, cause)
        if @health.positive?
          @health_updated = true
          cause.stats.add_damage(amount) if cause.respond_to?(:stats)
          @health = [@health - amount.to_i, 0].max
          after_death(cause) if dead?
        end
      end

      def draw
        return unless draw?

        @image.draw(x - @image.width / 2, y - object.graphics.height / 2 - @image.height, 100)
      end

      protected

      def draw?
        $debug
      end

      def update_image
        return unless draw?

        text = @health.to_s
        font_size = 18
        @image = Gosu::Image.from_text(text, font_size)
        @health_updated = false
      end

      def after_death(cause)
        Explosion.new(@object_pool, x, y) if @explodes
        cause.stats.add_kill if cause.respond_to?(:stats)
        object.mark_for_removal
      end
    end
  end
end
