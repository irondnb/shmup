# frozen_string_literal: true

module Shmup
  module Entities
    module Explosion
      class Sound
        class << self
          def play
            sound.play
          end

          private

          def sound
            @@sound ||= Gosu::Sample.new(Utils.asset_path('sounds/explosion_01.wav'))
          end
        end
      end
    end
  end
end
