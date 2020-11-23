module Shmup
  module Entities
    module Particle
      class Physics < Core::Component


        def update
          object.move(x + object.d_x, y + object.d_y)
          object.rotate #angle += (object.speed / 2)
          object.decay
          object.mark_for_removal if object.dead?
        end
      end
    end
  end
end
