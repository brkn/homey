# frozen_string_literal: true

class User
  include ActiveModel::Attributes
  include ActiveModel::AttributeAssignment
  include ActiveModel::Validations

  attribute :name, :string
  validates :name, presence: true

  def self.build_from_session(session)
    new.tap { |user| user.assign_attributes(name: session[:username]) }
  end
end
