module Shmup
  class Background
    attr_reader :game, :graphics, :position
    def initialize(game)
      @game = game
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/background.png'), tileable: false)
      @position = 0
    end

    def update
      @position += @game.world_speed
      @position = 0 if position >= @graphics.height
    end

    def draw
      @graphics.draw(0, position, 0)
      @graphics.draw(0, position - @graphics.height, 0)
    end
  end
end