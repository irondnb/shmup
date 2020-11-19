%w(
  window
  game
).each { |filename| require "shmup/core/#{filename}" }

module Shmup
  module Core
  end
end