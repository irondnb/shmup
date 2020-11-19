%w(
component
game_object
object_pool
  window
).each { |filename| require "shmup/core/#{filename}" }

module Shmup
  module Core
  end
end