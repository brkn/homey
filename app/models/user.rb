# frozen_string_literal: true

class User
  def initialize(name:)
    raise ArgumentError, "Name must be a non-empty string" unless valid_name?(name)

    @name = name.strip
  end

  attr_reader :name

  private

  def valid_name?(name)
    return false unless name.is_a?(String)
    return false if name.strip.empty?

    true
  end
end
