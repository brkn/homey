# frozen_string_literal: true

class Project < ApplicationRecord
  STATE = %w[
    todo
    in_progress
    done
    cancelled
  ].freeze
end
