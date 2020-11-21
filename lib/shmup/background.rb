# frozen_string_literal: true

module Shmup
  class Background
    attr_reader :game, :graphics, :position

    def initialize(object_pool)
      @object_pool = object_pool
      object_pool.background = self
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/background.png'), tileable: false)
      @position = 0
    end

    def update
      @position += @object_pool.world_speed
      @position = 0 if position >= @graphics.height
    end

    def draw
      @graphics.draw(0, position, ZOrder::BACKGROUND)
      @graphics.draw(0, position - @graphics.height, ZOrder::BACKGROUND)
    end
  end
end
