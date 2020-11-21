# frozen_string_literal: true

module Shmup
  class Health < Core::Component
    attr_accessor :health

    def initialize(object, health)
      super(object)
      @health, @initial_health = health
      @health_updated = true
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
      if @health > 0
        @health_updated = true
        if cause.respond_to?(:stats)
          cause.stats.add_damage(amount)
        end
        @health = [@health - amount.to_i, 0].max
        after_death(cause) if dead?
      end


    end

    def draw
      @image.draw(x - @image.width / 2, y - object.graphics.height / 2 - @image.height, 100)
    end

    protected

    def update_image
      return unless @health_updated

      text = @health.to_s
      font_size = 18
      @image = Gosu::Image.from_text(text, font_size)
    end

    def after_death(cause)
      cause.stats.add_kill if cause.respond_to?(:stats)
      object.mark_for_removal
    end
  end
end
