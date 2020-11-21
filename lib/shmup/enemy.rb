%w[
  definition
  movement
  ship
].each { |filename| require "shmup/enemy/#{filename}" }

module Shmup
  module Enemy
    class << self
      def load_sprite(name)
        @sprites ||= {}
        @sprites[name] ||= Gosu::Image.new(Utils.asset_path("/sprites/enemy/#{name}.png"), tileable: false)
      end

      def build_definitions(enemy_list, time_offset: 0)
        enemy_list.map do |e|
          Definition.new(
            e['spawn_time'] + time_offset,
            e['sprite'],
            e['offset'] * $window.width,
            movement(e['movement']),
            e['health']
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
