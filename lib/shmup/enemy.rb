%w[
  definition
  movement
  ship
].each { |filename| require "shmup/enemy/#{filename}" }

module Shmup
  module Enemy
    Sprites = {
        1 => Gosu::Image.new(Utils.asset_path('/sprites/enemy/spaceShips_001.png'), tileable: false)
    }.freeze

    class << self
      def build_definitions(enemy_list, time_offset: 0)
        enemy_list.map do |p|

          Definition.new(
            p['spawn_time'] + time_offset,
            p['sprite'],
            p['offset'] * $window.width,
            movement(p['movement'])
          )
        end
      end

      private

      def movement(name)
        case name
        when 'none'
          Movement::None
        when 'fast'
          Movement::Fast
        when 'medium'
          Movement::Medium
        else
          Movement::None
        end
      end
    end
  end
end
