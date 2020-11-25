# frozen_string_literal: true

module Shmup
  module Entities
    module Bullet
      class Base < Core::GameObject
        attr_accessor :angle
        attr_reader :source, :vel_x, :vel_y, :graphics, :physics, :damage

        def initialize(object_pool, source, x, y, vel_x, vel_y, damage)
          super(object_pool, x, y)
          @source = source
          @vel_x = vel_x
          @vel_y = vel_y
          @damage = damage

          @graphics = Graphics.new(self, sprite)
          @physics = Physics.new(self, object_pool)
          @sound = Sound.play
        end

        def fire
          @fired_at = Gosu.milliseconds
        end

        def box
          physics.box
        end

        private

        def sprite
          case damage
          when 0..100
            @bullet_light ||= Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_01.png'))
          when 100..300
            @bullet_medium ||= Gosu::Image.new(Utils.asset_path('/sprites/bullets/bullet_02.png'))
          end
        end
      end
    end
  end
end
