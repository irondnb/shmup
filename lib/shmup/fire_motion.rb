module Shmup
  module FireMotion
    None = ->(object, world_speed) { object.move(object.x, object.y - world_speed) }
    StrightUp = ->(object, world_speed) { object.move(object.x, object.y - world_speed) }
    StrightDown = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 2) }
  end
end
