# frozen_string_literal: true

module Shmup
  module Entities
    module Animation
      def update
        @current_frame ||= 0
        now = Gosu.milliseconds
        delta = now - (@last_frame ||= now)
        @last_frame = now if delta > frame_delay
        @current_frame += (delta / frame_delay).floor
        object.mark_for_removal if done?
      end

      def draw
        image = current_frame
        image.draw_rot(x, y, ZOrder::EFFECT, 0)
      end

      def effect?
        true
      end

      def box
        [x, y]
      end

      private

      def current_frame
        animation[@current_frame % animation.size]
      end

      def done?
        @done ||= @current_frame >= animation.size
      end

      def frame_delay
        16.66
      end
    end
  end
end
