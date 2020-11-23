# frozen_string_literal: true

module Shmup
  module FireMotion
    NONE = ->(object, _world_speed) {}
    DOWN = ->(object, world_speed) { object.move(object.x, object.y + world_speed * 2) }
    UP = ->(object, world_speed) { object.move(object.x, object.y - world_speed * 2) }
  end
end
