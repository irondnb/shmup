module Shmup
  module Core
    class Game
      attr_reader :window

      WORLD_SPEED = 10

      def initialize(window)
        @window = window
        @player = Player.new(window)
        @background = Gosu::Image.new(Utils.asset_path('/sprites/background.png'), tileable: false)
        @background_height = 0
      end

      def update
        @window.close if Gosu.button_down?(Gosu::KbEscape)
        @player.update

        @background_height += WORLD_SPEED
        @background_height = 0 if @background_height >= @background.height
        end

      def draw
        @background.draw(0, @background_height, 0)
        @background.draw(0, @background_height - @background.height, 0)

        @player.draw
      end


      private

      def reset_background_height
        @background_height = 0
      end
    end
  end
end