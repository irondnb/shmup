module Shmup
  module Core
    class Game
      attr_reader :window

      def initialize(window)
        @window = window
        @player = Player.new
      end

      def update
        @window.close if Gosu.button_down?(Gosu::KbEscape)
        @player.update
      end

      def draw
        @player.draw
      end
    end
  end
end