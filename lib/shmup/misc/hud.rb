# frozen_string_literal: true

module Shmup
  class Hud
    attr_reader :game, :ship

    def initialize(game)
      @game = game
      @ship = game.player
    end

    def health_image
      if @health.nil? || ship.health.health != @health
        @health = ship.health.health
        @health_image = Gosu::Image.from_text("Health: #{@health}, Lives: #{ship.lives}", 20)
      end
      @health_image
    end

    def stats_image
      stats = ship.stats
      if @stats_image.nil? || stats.changed_at <= Gosu.milliseconds
        @stats_image = Gosu::Image.from_text("Kills: #{stats.kills} Damage: #{stats.damage}", 20)
      end
      @stats_image
    end

    def level_info
      @level_info ||= Gosu::Image.from_text("Level: #{game.settings.name}", 15)
    end

    def game_over
      @game_over ||= Gosu::Image.from_text('Game Over', 120)
    end

    def winner_text
      @winner_text ||= Gosu::Image.from_text('Mission complete', 120)
    end

    def draw
      health_image.draw(100, $window.height - 200, ZOrder::HUD)
      stats_image.draw(100, $window.height - 150, ZOrder::HUD)
      level_info.draw(100, $window.height - 100, ZOrder::HUD)
      winner_text.draw_rot($window.width / 2, $window.height / 2, ZOrder::HUD, 0) if game.win?
      game_over.draw_rot($window.width / 2, $window.height / 2, ZOrder::HUD, 0) if game.lost?
    end
  end
end
