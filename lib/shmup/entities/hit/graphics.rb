module Shmup
  module Entities
    module Hit
      class Graphics < Core::Component
        include Animation

        private

        def animation
          @animation ||= Gosu::Image.load_tiles(
              Utils.asset_path("sprites/hits/#{rand(3)}_512_b.png"), 128, 128, tileable: false
          )
        end
      end
    end
  end
end
