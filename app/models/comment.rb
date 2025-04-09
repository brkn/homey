# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :project

  validates :content, presence: true
  validates :author, presence: true
end
