# frozen_string_literal: true

class Score < ApplicationRecord
  validates :score, presence: true, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }
  validates :player, presence: true

  scope :player, ->(player) { where player: player }
  scope :datetime, ->(before, after) { where created_at: after..before }
  scope :created_before, ->(before) { where('created_at <= ?', before) }
  scope :created_after, ->(after) { where('created_at >= ?', after) }
end
