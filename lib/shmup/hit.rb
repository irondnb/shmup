# frozen_string_literal: true

module Shmup
  class Hit < Effect
    
    private

    def animation
      @@animation ||= Gosu::Image.load_tiles(
        Utils.asset_path('sprites/hits/0.png'), 512, 512, tileable: false
      )
    end
  end
end
