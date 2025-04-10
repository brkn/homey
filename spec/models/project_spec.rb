# frozen_string_literal: true

require "rails_helper"

RSpec.describe Project do
  describe "#state" do
    it "returns 'todo' when no state changes exist" do
      project = described_class.create!(name: "New Project")

      expect(project.state).to eq("todo")
    end

    it "returns the most recent state change" do
      project = described_class.create!(name: "Test Project")

      project.state_changes.create!(
        from_state: "todo",
        to_state: "in_progress",
        author: "John",
      )

      expect(project.state).to eq("in_progress")

      project.state_changes.create!(
        from_state: "in_progress",
        to_state: "done",
        author: "Berkan",
      )

      expect(project.state).to eq("done")
    end
  end

  describe "#change_state_to" do
    let(:project) { described_class.create(name: "Test Project") }

    it "creates a state change record for valid transitions" do
      result = project.change_state_to(:in_progress, author: "brkn")

      expect(result).to be_a(StateChange)
      expect(result).to be_persisted
      expect(project.state).to eq("in_progress")
    end

    it "returns state change with errors for invalid transitions" do
      result = project.change_state_to(:done, author: "brkn")

      expect(result).to be_a(StateChange)
      expect(result.errors[:to_state]).to be_present
      expect(project.reload.state).to eq("todo")
    end
  end

  describe "#change_state_to!" do
    let(:project) { described_class.create(name: "Test Project") }

    it "changes state for valid transitions" do
      project.change_state_to!(:in_progress, author: "brkn")
      expect(project.state).to eq("in_progress")
    end

    it "raises error for invalid transitions" do
      expect do
        project.change_state_to!(:done, author: "brkn")
      end.to raise_error(ActiveRecord::RecordInvalid)

      expect(project.state).to eq("todo")
    end
  end
end
