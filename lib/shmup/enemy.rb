module Shmup
  class Enemy < Core::GameObject
    def initialize(object_pool)
      super(object_pool, rand($window.width), 0)
      @graphics = Gosu::Image.new(Utils.asset_path('/sprites/enemy/spaceShips_001.png'), tileable: false)
    end

    def update
      @y = @y + 8
    end

    def draw
      @graphics.draw(x, y, 1)
    end
  end
end