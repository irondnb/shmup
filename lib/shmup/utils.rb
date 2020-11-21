# frozen_string_literal: true

module Shmup
  module Utils
    DEBUG_COLORS = [
      Gosu::Color::AQUA,
      Gosu::Color::RED,
      Gosu::Color::GREEN,
      Gosu::Color::BLUE,
      Gosu::Color::YELLOW,
      Gosu::Color::FUCHSIA,
      Gosu::Color::CYAN
    ].freeze

    class << self
      def asset_path(filepath)
        File.join(assets_path, filepath)
      end

      def assets_path
        @assets_path ||= File.expand_path('../../assets', __dir__)
      end

      def level_path(id)
        File.join(assets_path, 'levels', "level_#{id}.yml")
      end

      def track_update_interval
        now = Gosu.milliseconds
        @update_interval = (now - (@last_update ||= 0)).to_f
        @last_update = now
      end

      def adjust_speed(speed)
        speed * update_interval / 33.33
      end

      def mark_corners(box)
        i = 0
        box.each_slice(2) do |x, y|
          color = DEBUG_COLORS[i]
          $window.draw_triangle(
            x - 5, y - 5, color,
            x,     y,     color,
            x + 5, y - 5, color,
            100
          )
          i = (i + 1) % 7
        end
      end

      def point_in_poly(testx, testy, *poly)
        nvert = poly.size / 2 # Number of vertices in poly
        vertx = []
        verty = []
        poly.each_slice(2) do |x, y|
          vertx << x
          verty << y
        end
        inside = false
        j = nvert - 1
        (0..nvert - 1).each do |i|
          if ((verty[i] > testy) != (verty[j] > testy)) &&
             (testx < (vertx[j] - vertx[i]) * (testy - verty[i]) /
                 (verty[j] - verty[i]) + vertx[i])
            inside = !inside
          end
          j = i
        end
        inside
      end
    end
  end
end
