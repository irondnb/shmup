module Shmup
  module States
    class PlayState < GameState
      require 'yaml'

      attr_reader :object_pool, :world_speed

      WORLD_SPEED = 10

      def initialize
        super
        @object_pool = Core::ObjectPool.new
        @object_pool.world_speed = WORLD_SPEED
        @background = Background.new(@object_pool)
        @player = Player.new(@object_pool)
        @game_over = Gosu::Image.from_text("Game Over", 120)
        build_enemies
      end

      def update
        $window.close if Gosu.button_down?(Gosu::KbEscape)

        if @player.alive?
          # build_enemies if @enemies.empty?
          Enemy::Ship.new(@object_pool, @enemies.shift) if !@enemies.empty? && Gosu.milliseconds >= @enemies.first.spawn_time
          @object_pool.update_all
        end
      end

      def draw
        @background.draw
        @object_pool.objects.each(&:draw)
        @game_over.draw_rot($window.width / 2, $window.height / 2, 1, 0) unless @player.alive?
      end

      private

      def load_enemies
        YAML.safe_load(File.open(Utils.level_path('01')))['enemies']
      end

      def build_enemies
        @enemies = Enemy.build_definitions(load_enemies, time_offset: Gosu.milliseconds)
      end
    end
  end
end
