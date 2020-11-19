module Shmup
  module Utils
    class << self
      def asset_path(filepath)
        File.join(assets_path, filepath)
      end

      def assets_path
        @assets_path ||= File.expand_path('../../../assets', __FILE__)
      end
    end
  end

  module ZOrder
    Background, Player, Hud = 0..2
  end
end
