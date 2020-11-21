# frozen_string_literal: true

module Shmup
  module Core
    class Window < Gosu::Window
      attr_accessor :state

      attr_reader :game

      WIDTH = 960 # 480
      HEIGHT = 1280 # 640
      FULLSCREEN = false

      def initialize
        super(WIDTH, HEIGHT, FULLSCREEN)
      end

      def update
        Utils.track_update_interval
        @state.update
      end

      def draw
        @state.draw
        Gosu::Image
      end

      def needs_redraw?
        @state.needs_redraw?
      end

      def needs_cursor?
        false
      end

      def button_down(id)
        @state.button_down(id)
      end
    end
  end
end
