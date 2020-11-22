# frozen_string_literal: true

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
        @hud = Hud.new(@player)
        build_enemies
      end

      def update
        spawn_enemy if enemy_ready?
        @object_pool.update_all
      end

      def draw
        @background.draw
        @object_pool.objects.each(&:draw)
        @hud.draw
      end

      def button_down(id)
        $window.close! if id == Gosu::KbEscape
        toggle_profiling if id == Gosu::KbF2
        $debug = !$debug if id == Gosu::KbF1
      end

      def leave
        toggle_profiling if @profiling_now
        puts "Pool: #{@object_pool.objects.size}"
      end

      private

      def spawn_enemy
        Enemy.new(@object_pool, @enemies.shift)
      end

      def enemy_ready?
        !@enemies.empty? && Gosu.milliseconds >= @enemies.first.spawn_time
      end

      def load_enemies
        YAML.safe_load(File.open(Utils.level_path('02')))['enemies']
      end

      def build_enemies
        @enemies = Enemy.build_definitions(load_enemies, time_offset: Gosu.milliseconds + 1000)
      end

      def toggle_profiling
        require 'ruby-prof' unless defined?(RubyProf)
        if @profiling_now
          result = RubyProf.stop
          printer = RubyProf::FlatPrinter.new(result)
          printer.print($stdout)
          @profiling_now = false
        else
          RubyProf.start
          @profiling_now = true
        end
      end
    end
  end
end
