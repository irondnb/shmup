# frozen_string_literal: true

module Shmup
  module Entities
    module Player
      class Health < Components::Health
        def after_death(_cause)
          Explosion::Base.new(@object_pool, x, y)
          object.die
        end
      end
    end
  end
end
