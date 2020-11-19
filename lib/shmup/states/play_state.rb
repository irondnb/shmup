module Shmup
  module States
    class PlayState < GameState
      attr_reader :object_pool, :world_speed

      def initialize
        @object_pool = Core::ObjectPool.new
        @background = Background.new(self)
        @player = Player.new(@object_pool)

        3.times do
          Enemy.new(@object_pool)
        end

        @world_speed = 15
      end

      def update
        $window.close if Gosu.button_down?(Gosu::KbEscape)
        @background.update
        @object_pool.update_all
      end

      def draw
        @background.draw
        @object_pool.objects.each(&:draw)
      end
    end
  end
end