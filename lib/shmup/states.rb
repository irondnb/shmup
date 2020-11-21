# frozen_string_literal: true

%w[
  game_state
  play_state
].each { |filename| require "shmup/states/#{filename}" }

module Shmup
  module States
  end
end
