# frozen_string_literal: true

module Shmup
  module Entities
    class Explosion < Effect
      def initialize(object_pool, x, y)
        super(object_pool, x, y)
        @particle_emitter = ParticleEmitter.new(self, object_pool)
      end

      private

      def animation
        @@animation ||= Gosu::Image.load_tiles(
          Utils.asset_path('sprites/explosion.png'), 256, 256, tileable: false
        )
      end

      def sound
        @@sound ||= Gosu::Sample.new(Utils.asset_path('sounds/explosion_01.wav'))
      end
    end
  end
end
