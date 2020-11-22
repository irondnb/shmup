module Shmup
  module Entities
    module Enemy
      Definition = Struct.new(:spawn_time, :sprite, :offset, :movement, :fire_motion, :health) do
        def initialize(*args)
          super(*args)
          self.spawn_time = spawn_time + Gosu.milliseconds
          self.offset = offset * $window.width
          self.movement = set_movement(movement)
          self.fire_motion = set_fire_motion(fire_motion)
        end

        def set_movement(movement)
          eval "Movement::#{movement.upcase}"
        rescue NameError => e
          Movement::NONE
        end

        def set_fire_motion(fire_motion)
          eval "FireMotion::#{fire_motion.upcase}"
        rescue NameError => e
          FireMotion::NONE
        end
      end
    end
  end
end