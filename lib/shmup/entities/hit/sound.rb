module Shmup
  module Entities
    module Hit
      class Sound
        class << self
          def play
            sound.play
          end

          private

          def sound
            @@sound ||= Gosu::Sample.new(Utils.asset_path('sounds/hit_01.mp3'))
          end
        end
      end
    end
  end
end
