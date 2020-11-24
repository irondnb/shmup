# frozen_string_literal: true

module Shmup
  module States
    class MenuState < GameState
      require 'singleton'
      include Singleton
      attr_accessor :play_state

      def initialize
        @message = Gosu::Image.from_text('Shmup', 100)
        @info = Gosu::Image.from_text("Press:\n 1 - 2 \nQ: Quit", 50)
      end

      def enter; end

      def leave; end

      def update; end

      def draw
        @message.draw(
          $window.width / 2 - @message.width / 2,
          $window.height / 2 - @message.height / 2 - 200,
          10
        )
        @info.draw(
          $window.width / 2 - @message.width / 2,
          $window.height / 2 - @message.height / 2,
          10
        )
      end

      def button_down(id)
        $window.close if id == Gosu::KbQ

        if id == Gosu::KbEnter
          @play_state = PlayState.new
          GameState.switch(@play_state)
        end
      end
    end
  end
end
