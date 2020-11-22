# frozen_string_literal: true

module Shmup
  module Player
    class Input < Core::Component
      def update
        object.physics.move_up    if Gosu.button_down?(Gosu::KbUp)
        object.physics.move_left  if Gosu.button_down?(Gosu::KbLeft)
        object.physics.move_right if Gosu.button_down?(Gosu::KbRight)
        object.physics.move_down  if Gosu.button_down?(Gosu::KbDown)
        object.shoot              if Gosu.button_down?(Gosu::KbSpace)
      end
    end
  end
end
