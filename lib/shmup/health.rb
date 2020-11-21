# frozen_string_literal: true

module Shmup
  class Health < Core::Component
    attr_accessor :health

    def initialize(object, health)
      super(object)
      @health, @initial_health = health
      update_image
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

    def inflict_damage(amount)
      @health = [@health - amount.to_i, 0].max
      after_death if dead?
    end

    def draw
      @image.draw(x - @image.width / 2, y - object.graphics.height / 2 - @image.height, 100)
    end

    protected

    def update_image
      text = @health.to_s
      font_size = 18
      @image = Gosu::Image.from_text(text, font_size)
    end

    def after_death
      object.mark_for_removal
    end
  end
end
