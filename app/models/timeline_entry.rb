# frozen_string_literal: true

class TimelineEntry < ApplicationRecord
  belongs_to :project

  validates :author, presence: true

  default_scope { order(created_at: :asc) }

  broadcasts_to :project
end
