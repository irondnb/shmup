module Shmup
  module States
    class PlayState < GameState
      attr_reader :object_pool, :world_speed

      def initialize
        @object_pool = Core::ObjectPool.new
        @background = Background.new(self)
        @player = Player.new(@object_pool)

        enemy_sprite = Gosu::Image.new(Utils.asset_path('/sprites/enemy/spaceShips_001.png'), tileable: false)

        @enemy_definitions = [
            EnemyDefiniton.new(1000, enemy_sprite, 200),
            EnemyDefiniton.new(1000, enemy_sprite, 800),
            EnemyDefiniton.new(2000, enemy_sprite, 200),
            EnemyDefiniton.new(2000, enemy_sprite, 800),
            EnemyDefiniton.new(3000, enemy_sprite, 200),
            EnemyDefiniton.new(3000, enemy_sprite, 800),
            EnemyDefiniton.new(4000, enemy_sprite, 200),
            EnemyDefiniton.new(4000, enemy_sprite, 800),
            EnemyDefiniton.new(5000, enemy_sprite, 200),
            EnemyDefiniton.new(5000, enemy_sprite, 800),
        ]

        @world_speed = 15
      end

      def update
        $window.close if Gosu.button_down?(Gosu::KbEscape)
        @background.update

        if !@enemy_definitions.empty? && Gosu.milliseconds >= @enemy_definitions.first.spawn_time
          Enemy.new(@object_pool, @enemy_definitions.shift)
        end

        @object_pool.update_all
      end

      def draw
        @background.draw
        @object_pool.objects.each(&:draw)
      end
    end
  end
end