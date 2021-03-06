# frozen_string_literal: true

module Shmup
  module Entities
    module Explosion
      class Base < Core::GameObject
        def initialize(object_pool, x, y)
          super(object_pool, x, y)
          @graphics = Graphics.new(self)
          @sound = Sound.play
          @particle_emitter = Components::ParticleEmitter.new(self, object_pool)
        end

        def effect?
          true
        end

        def box
          [x, y]
        end

        def update
          move(x, y + object_pool.world_speed)
          super
        end
      end
    end
  end
end
