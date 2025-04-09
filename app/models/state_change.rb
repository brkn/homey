# frozen_string_literal: true

class StateChange < ApplicationRecord
  belongs_to :project

  validates :from_state, :to_state, inclusion: { in: Project::STATE }
end
