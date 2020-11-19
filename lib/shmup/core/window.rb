module Shmup
  module Core
    class Window < Gosu::Window
      attr_reader :game

      WIDTH = 480
      HEIGHT = 640
      FULLSCREEN = false

      def initialize
        super(WIDTH, HEIGHT, FULLSCREEN)
        @game = Game.new(self)
      end

      def update
        @game.update
      end

      def draw
        @game.draw
      end

      def needs_cursor?
        false
      end
    end
  end
end