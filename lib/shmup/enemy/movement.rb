module Shmup
  module Enemy
    module Movement
      None = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.25) }
      Fast = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.75) }
    end
  end
end
