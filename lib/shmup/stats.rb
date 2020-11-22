# frozen_string_literal: true

module Shmup
  class Stats
    attr_reader :kills, :deaths, :changed_at

    def initialize
      @kills = @damage = 0
      changed
    end

    def add_kill(amount = 1)
      @kills += amount
      changed
    end

    def add_damage(amount)
      @damage += amount
      changed
    end

    def damage
      @damage.round
    end

    def to_s
      "kills: #{@kills}, " \
      "damage: #{damage}, " \
    end

    private

    def changed
      @changed_at = Gosu.milliseconds
    end
  end
end
