module Shmup
  module States
    class PlayState < GameState
      require 'yaml'

      attr_reader :object_pool, :world_speed

      def initialize
        super
        @object_pool = Core::ObjectPool.new
        @background = Background.new(self)
        @player = Player.new(@object_pool)
        enemy_patterns = YAML.safe_load(File.open(Utils.level_path('01')))['enemies']
        @enemy_definitions = enemy_patterns.map { |p| EnemyDefiniton.new(p['spawn_time'], p['sprite'], p['offset'] * $window.width) }
        @world_speed = 20
        @game_over = Gosu::Image.from_text("Game Over", 120)
      end

      def update
        $window.close if Gosu.button_down?(Gosu::KbEscape)

        if @player.alive?
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
        @game_over.draw_rot($window.width / 2, $window.height / 2, 1, 0) unless @player.alive?
      end
    end
  end
end
