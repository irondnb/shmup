module Shmup
  module States
    class PlayState < GameState
      attr_reader :object_pool, :world_speed

      def initialize
        @object_pool = Core::ObjectPool.new
        @background = Background.new(self)
        @player = Player.new(@object_pool)

        enemy_sprite = Gosu::Image.new(Utils.asset_path('/sprites/enemy/spaceShips_001.png'), tileable: false)


        wave_one = [
            { spawn_time: 1250, sprite: enemy_sprite, position_x: $window.width / 4 },
            { spawn_time: 1250, sprite: enemy_sprite, position_x: ($window.width / 2) + $window.width / 4 },
            { spawn_time: 1500, sprite: enemy_sprite, position_x: $window.width / 8 },
            { spawn_time: 1500, sprite: enemy_sprite, position_x: ($window.width * 3) / 8 },
            { spawn_time: 1500, sprite: enemy_sprite, position_x: ($window.width / 2) + $window.width / 8 },
            { spawn_time: 1500, sprite: enemy_sprite, position_x: ($window.width / 2) + ($window.width * 3) / 8 }
        ]

        wave_two = [
            { spawn_time: 1000, sprite: enemy_sprite, position_x: $window.width / 2 },
            { spawn_time: 1250, sprite: enemy_sprite, position_x: $window.width / 3 },
            { spawn_time: 1250, sprite: enemy_sprite, position_x: $window.width * 2 / 3 },
            { spawn_time: 1500, sprite: enemy_sprite, position_x: $window.width / 5 },
            { spawn_time: 1500, sprite: enemy_sprite, position_x: ($window.width / 2) + ($window.width / 3) },
            { spawn_time: 1500, sprite: enemy_sprite, position_x: ($window.width / 2) }
        ]
        enemy_patterns = wave_one + wave_two.map { |w| w[:spawn_time] =  w[:spawn_time] + 2000; w }

        @enemy_definitions = enemy_patterns.map { |p| EnemyDefiniton.new(p[:spawn_time], p[:sprite], p[:position_x]) }

        @world_speed = 20
      end

      def update
        $window.close if Gosu.button_down?(Gosu::KbEscape)

        unless @player.dead?
          if !@enemy_definitions.empty? && Gosu.milliseconds >= @enemy_definitions.first.spawn_time
            Enemy.new(@object_pool, @enemy_definitions.shift)
          end

          @background.update
          @object_pool.update_all
        end
      end

      def draw
        @background.draw
        @object_pool.objects.each(&:draw)
      end
    end
  end
end