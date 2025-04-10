# frozen_string_literal: true

class Comment < TimelineEntry
  validates :content, presence: true
end
