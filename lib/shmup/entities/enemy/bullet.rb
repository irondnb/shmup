module Shmup
  module Entities
    module Enemy
      class Bullet < Shmup::Entities::Bullet::Base

        private

        def sprite
          case damage
          when 0..100
            @@red_bullet_light ||= Gosu::Image.new(Utils.asset_path('/sprites/bullets/red_bullet_01.png'))
          when 100..300
            @@red_bullet_medium ||= Gosu::Image.new(Utils.asset_path('/sprites/bullets/red_bullet_02.png'))
          end
        end
      end
    end
  end
end