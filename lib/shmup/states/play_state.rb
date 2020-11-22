# frozen_string_literal: true

module Shmup
  module States
    class PlayState < GameState
      require 'yaml'

      attr_reader :object_pool, :player, :enemies, :settings
      attr_accessor :world_speed

      SWITCH_DELAY = 3000
      Settings = Struct.new(:name, :world_speed, :time, :enemies, :boss)

      def self.build(config)
        settings = Settings.new(config['name'], config['world_speed'], config['time'], config['enemies'], config['boss'])

        new(settings)
      end


      def initialize(settings)
        @settings = settings
        @object_pool = Core::ObjectPool.new
        @object_pool.world_speed = settings.world_speed

        @background = Entities::Background.new(@object_pool)
        @enemies = Entities::Enemy.build(settings.enemies)
        @player = Entities::Player.new(@object_pool)
        @boss = Entities::Enemy.build_boss(settings.boss)
        @hud = Hud.new(self)

      end

      def update
        if win? || lost?
          @switch_delay ||= Gosu.milliseconds
          if Gosu.milliseconds - @switch_delay >= SWITCH_DELAY
            GameState.switch(MenuState.instance)
          end
        end

        spawn_enemy if spawn_enemy?

        if @boss
          spawn_boss if spawn_boss?
          win! if @boss_entity&.dead?
        else
          win! if settings.time && Gosu.milliseconds >= settings.time
        end

        if !win? && @player.dead?
          lost!
        end

        @object_pool.update_all
      end

      def draw
        @background.draw
        @object_pool.objects.each(&:draw)
        @hud.draw
      end

      def button_down(id)
        GameState.switch(MenuState.instance) if id == Gosu::KbEscape
        toggle_profiling if id == Gosu::KbF2
        $debug = !$debug if id == Gosu::KbF1
      end

      def leave
        toggle_profiling if @profiling_now
        puts "Pool: #{@object_pool.objects.size}"
      end

      def win?
        @win
      end

      def lost?
        @lost
      end

      private

      def win!
        @win = true
      end

      def lost!
        @lost = true
      end

      def spawn_enemy
        Entities::Enemy.spawn(@object_pool, @enemies.shift)
      end

      def spawn_boss
        @boss_entity = Entities::Enemy.spawn(@object_pool, @boss)
      end

      def spawn_enemy?
        !@enemies.empty? && Gosu.milliseconds >= @enemies.first.spawn_time
      end

      def spawn_boss?
        Gosu.milliseconds >= @boss.spawn_time && @boss_entity.nil?
      end

      def load_enemies
        ['enemies']
      end

      def build_enemies
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
