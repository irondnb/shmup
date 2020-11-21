module Shmup
  module FireMotion
    StrightUp = ->(object, world_speed) { object.move(object.x, object.y - world_speed) }
  end
end
