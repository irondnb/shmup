module Shmup
  module Enemy
    module Movement
      None = ->(object, world_speed) { object.move(object.x, object.y + world_speed) }
      Slow = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.25) }
      Fast = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 1.5) }
      SlowNorth = ->(object, world_speed) { object.move(object.x, object.y + world_speed - world_speed * 0.50)}
      SouthEast = ->(object, world_speed) { object.move(object.x + world_speed * 0.75, object.y + world_speed * 1.25) }
      SouthWest = ->(object, world_speed) { object.move(object.x - world_speed * 0.75, object.y + world_speed * 1.25) }
    end
  end
end
