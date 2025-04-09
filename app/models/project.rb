# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :state_changes, dependent: :destroy

  has_one :latest_state_change,
          -> { where.not(id: nil).order(created_at: :desc) },
          class_name: "StateChange",
          dependent: :nullify,
          inverse_of: :project

  def state
    return "todo" if latest_state_change.blank?

    latest_state_change.to_state
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
