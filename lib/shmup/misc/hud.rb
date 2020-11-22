# frozen_string_literal: true

module Shmup
  class Hud
    attr_reader :ship

    def initialize(ship)
      @ship = ship
      @game_over_text = Gosu::Image.from_text('Game Over', 120)
    end

    def health_image
      if @health.nil? || ship.health.health != @health
        @health = ship.health.health
        @health_image = Gosu::Image.from_text("Health: #{@health}", 20)
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

    def draw
      health_image.draw(100, $window.height - 200, ZOrder::HUD)
      stats_image.draw(100, $window.height - 150, ZOrder::HUD)
      @game_over_text.draw_rot($window.width / 2, $window.height / 2, ZOrder::HUD, 0) if ship.dead?
    end
  end
end
