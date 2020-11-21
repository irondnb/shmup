# frozen_string_literal: true

module Shmup
  class Explosion < Core::GameObject
    attr_accessor :x, :y

    FRAME_DELAY = 8.33 # ms

    def initialize(object_pool, x, y)
      super(object_pool, x, y)
      @current_frame = 0
    end

    def effect?
      true
    end

    def box
      [x, y]
    end

    def draw
      image = current_frame
      image.draw(
        x - image.width / 2 + 3,
        y - image.height / 2 - 35,
        20
      )
    end

    def update
      now = Gosu.milliseconds
      delta = now - (@last_frame ||= now)
      @last_frame = now if delta > FRAME_DELAY
      @current_frame += (delta / FRAME_DELAY).floor
      mark_for_removal if done?
    end

    private

    def current_frame
      animation[@current_frame % animation.size]
    end

    def done?
      @done ||= @current_frame >= animation.size
    end

    def animation
      @@animation ||= Gosu::Image.load_tiles(
        Utils.asset_path('sprites/explosion.png'), 256, 256, tileable: false
      )
    end
  end
end
