# frozen_string_literal: true

module Shmup
  module Entities
    module Components
      class ParticleEmitter < Core::Component
        attr_reader :object, :object_pool, :sprites

        SPRITES = %w[cockpit engine_01 engine_02 gun_01 gun_02 gun_03 wing_01 wing_02 wing_03].freeze
        DECAY_TIME = 0.025
        EMMIT_TIME = 260

        def initialize(object, object_pool, sprites = SPRITES)
          super(object)
          @object_pool = object_pool
          @object = object
          @particles = []
          @sprites = sprites.collect { |s| Gosu::Image.new(Utils.asset_path("/sprites/parts/#{s}.png"), tileable: false) }
        end

        def update
          now = Gosu.milliseconds
          @spawned_at ||= now
          spawn(rand * 360, (rand * 10)) unless now > @spawned_at + EMMIT_TIME
        end

        def spawn(angle, speed)
          Particle::Base.new(object_pool, object.x, object.y + object_pool.world_speed,
                       sprites[(rand * sprites.size).floor], angle, speed, decay_time)
        end

        private

        def decay_time
          DECAY_TIME
        end
      end
    end
  end
end
