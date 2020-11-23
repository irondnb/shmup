module Shmup
  module Entities
    module Player
      class Health < Components::Health
        def after_death(cause)
          Explosion.new(@object_pool, x, y)
          object.die
        end
      end
    end
  end
end