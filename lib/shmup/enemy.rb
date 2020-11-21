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
            fire_motion(e['fire_motion']),
            e['health']
          )
        end
      end

      private

      def movement(name)
        eval "Movement::#{name.upcase}"
      rescue NameError => e
        logger.fatal(e.full_message)
        Movement::NONE
      end

      def fire_motion(name)
        eval "FireMotion::#{name.upcase}"
      rescue NameError => e
        logger.fatal(e.full_message)
        FireMotion::NONE
      end
    end
  end
end
