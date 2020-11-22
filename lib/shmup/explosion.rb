# frozen_string_literal: true

module Shmup
  class Explosion < Effect
    private

    def animation
      @@animation ||= Gosu::Image.load_tiles(
        Utils.asset_path('sprites/explosion.png'), 256, 256, tileable: false
      )
    end
  end
end
