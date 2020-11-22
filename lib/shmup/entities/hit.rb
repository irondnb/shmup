# frozen_string_literal: true

module Shmup
  module Entities
    class Hit < Effect
      private

      def animation
        @animation ||= Gosu::Image.load_tiles(
          Utils.asset_path("sprites/hits/#{rand(3)}_512_b.png"), 128, 128, tileable: false
        )
      end
    end
  end
end
