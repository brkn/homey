# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectsController do
  describe "GET #show" do
    render_views

    let!(:project) { Project.create!(name: "Test Project") }
    let(:user_name) { "First commenter" }
    let(:transition_button_texts) do
      response.parsed_body
              .at_css("#state-transition-buttons")
              .css("button")
              .map(&:text)
    end

    before do
      session[:username] = user_name

      project.change_state_to!("in_progress", author: "State changing user")
      project.comments.create!(content: "First comment", author: "First commenting user")
      project.comments.create!(content: "Second comment", author: "Second user")
    end

    it "renders the project with its timeline" do
      get :show

      expect(response).to have_http_status(:ok)

      expect(response.parsed_body.at_css("#project_name").text).to eq "Test Project"
      expect(response.parsed_body.at_css("#project-state").text).to eq "in_progress"
      expect(response.parsed_body.at_css("#timeline_entries_container")).to be_present
      expect(response.parsed_body.at_css("#new-comment-form")).to be_present
    end

    it "renders timeline items" do
      get :show

      expect(response.parsed_body.at_css(".comment-content").text).to include("First comment")
      expect(response.parsed_body.at_css(".comment-author").text).to include("First commenting user")

      expect(response.parsed_body.css(".timeline-item").length).to eq(3)
    end

    it "includes state transition buttons" do
      get :show

      expect(response.parsed_body.css("#state-transition-buttons")).to be_present
      expect(transition_button_texts).to eq ["Change to Done", "Change to Cancelled"]
    end
  end

  describe "PATCH #update" do
    before do
      session[:username] = "Test User"
    end

    let!(:project) { Project.create!(name: "Test Project") }

    context "with valid state transition" do
      it "changes project state to a valid state" do
        patch :update, params: { project: { state: "in_progress" }, format: :json }

        expect(response).to have_http_status(:ok)
        expect(project.state).to eq("in_progress")
      end
    end

    context "with invalid state transition" do
      it "does not change project state to an invalid state" do
        patch :update, params: { project: { state: "done" }, format: :json }

        expect(response).to have_http_status(:bad_request)
        expect(project.state).to eq("todo")
      end
    end
  end
end
