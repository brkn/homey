# frozen_string_literal: true

class StateChange < ApplicationRecord
  VALID_TRANSITIONS = {
    "todo" => ["in_progress", "cancelled"],
    "in_progress" => ["done", "cancelled"],
    "done" => ["cancelled"],
    "cancelled" => ["todo"],
  }.freeze

  VALID_STATES = VALID_TRANSITIONS.keys.freeze

  belongs_to :project

  validates :from_state, :to_state, inclusion: { in: VALID_STATES }

  validate :valid_transition_change, on: :create

  private

  def valid_transition_change
    return if VALID_TRANSITIONS.fetch(from_state, []).include?(to_state)

    errors.add(:to_state, "is not a valid transition from #{from_state}")
  end
end
