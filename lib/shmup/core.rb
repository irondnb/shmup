%w[
  component
  game_object
  object_pool
  quadtree
  axis_aligned_bounding_box
  window
].each { |filename| require "shmup/core/#{filename}" }

module Shmup
  module Core
  end
end