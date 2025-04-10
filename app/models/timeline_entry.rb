# frozen_string_literal: true

class TimelineEntry < ApplicationRecord
  belongs_to :project

  validates :author, presence: true
end
