module Shmup
  module Entities
    module Explosion
      class Base  < Core::GameObject
        def initialize(object_pool, x, y)
          super(object_pool, x, y)
          @graphics = Graphics.new(self)
          @sound = Sound.play
          @particle_emitter = Components::ParticleEmitter.new(self, object_pool)
        end
      end
    end
  end
end