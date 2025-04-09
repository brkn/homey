# frozen_string_literal: true

require "rails_helper"

RSpec.describe StateChange do
  let(:project) { Project.create!(name: "Test Project") }

  it "is valid with both valid states" do
    state_change = described_class.new(
      from_state: "todo",
      to_state: "in_progress",
      author: "John",
      project: project,
    )

    expect(state_change).to be_valid
  end

  it "is invalid with from_state not in valid states list" do
    state_change = described_class.new(
      from_state: "invalid_state",
      to_state: "in_progress",
      author: "John",
      project: project,
    )

    state_change.valid?

    expect(state_change.errors[:from_state]).to include("is not included in the list")
  end

  it "is invalid with to_state not in valid states list" do
    state_change = described_class.new(
      from_state: "todo",
      to_state: "invalid_state",
      author: "John",
      project: project,
    )

    state_change.valid?

    expect(state_change.errors[:to_state]).to include("is not included in the list")
  end
end
