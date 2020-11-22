# frozen_string_literal: true

module Shmup
  module Enemy
    class Physics < Core::Component
      attr_reader :movement, :offset

      def initialize(game_object, object_pool, definition)
        super(game_object)
        @movement = definition.movement
        @offset = definition.offset
        @object_pool = object_pool
      end

      def update
        movement.call(object, @object_pool.world_speed)
      end
    end
  end
end
