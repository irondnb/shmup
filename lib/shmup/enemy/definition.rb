# frozen_string_literal: true

module Shmup
  module Enemy
    Definition = Struct.new(:spawn_time, :sprite, :offset, :movement, :fire_motion, :health)
  end
end
