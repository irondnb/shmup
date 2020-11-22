# frozen_string_literal: true

%w[
  utils
  fire_motion
  hud
  stats
  z_order
].each { |filename| require "shmup/misc/#{filename}" }
