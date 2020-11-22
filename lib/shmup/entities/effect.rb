# frozen_string_literal: true

module Shmup
  module Entities
    class Effect < Core::GameObject
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

      def update
        now = Gosu.milliseconds
        delta = now - (@last_frame ||= now)
        @last_frame = now if delta > FRAME_DELAY
        @current_frame += (delta / FRAME_DELAY).floor
        mark_for_removal if done?
      end

      def draw
        image = current_frame
        image.draw_rot(x, y, ZOrder::EFFECT, 0)
      end

      private

      def current_frame
        animation[@current_frame % animation.size]
      end

      def done?
        @done ||= @current_frame >= animation.size
      end

      def animation
        raise NotImplementedError
      end
    end
  end
end
