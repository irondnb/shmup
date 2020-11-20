module Shmup
  module Utils
    class << self
      def asset_path(filepath)
        File.join(assets_path, filepath)
      end

      def assets_path
        @assets_path ||= File.expand_path('../../../assets', __FILE__)
      end

      def level_path(id)
        File.join(assets_path, 'levels', "level_#{id}.yml")
      end

      def adjust_speed(speed)
        speed * update_interval / 33.33
      end
    end
  end



  module ZOrder
    Background, Player, Hud = 0..2
  end
end
