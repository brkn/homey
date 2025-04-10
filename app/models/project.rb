# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :timeline_entries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :state_changes, dependent: :destroy

  def state
    state_changes.last&.to_state || "todo"
  end

  def change_state_to(new_state, author:)
    state_changes.create(
      from_state: state,
      to_state: new_state.to_s,
      author: author,
    )
  end

  def change_state_to!(new_state, author:)
    state_changes.create!(
      from_state: state,
      to_state: new_state.to_s,
      author: author,
    )
  end
end
