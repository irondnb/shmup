module Shmup
  module States
    class PlayState < GameState
      require 'yaml'

      attr_reader :object_pool
      attr_accessor :world_speed

      WORLD_SPEED = 5

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
        unless @player.dead?
          Enemy::Ship.new(@object_pool, @enemies.shift) if !@enemies.empty? && Gosu.milliseconds >= @enemies.first.spawn_time
          @object_pool.update_all
        end
      end

      def draw
        @background.draw
        @object_pool.objects.each(&:draw)
        @game_over.draw_rot($window.width / 2, $window.height / 2, 1, 0) if @player.dead?
      end

      def button_down(id)
        $window.close if id == Gosu::KbEscape
        toggle_profiling if id == Gosu::KbF2
        toggle_profiling if id == Gosu::KbF2
      end

      private

      def load_enemies
        YAML.safe_load(File.open(Utils.level_path('01')))['enemies']
      end

      def build_enemies
        @enemies = Enemy.build_definitions(load_enemies, time_offset: Gosu.milliseconds + 1000)
      end

      def toggle_profiling
        require 'ruby-prof' unless defined?(RubyProf)
        if @profiling_now
          result = RubyProf.stop
          printer = RubyProf::FlatPrinter.new(result)
          printer.print(STDOUT)
          @profiling_now = false
        else
          RubyProf.start
          @profiling_now = true
        end
      end
    end
  end
end
