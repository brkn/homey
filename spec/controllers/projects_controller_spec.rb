# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectsController do
  describe "GET #show" do
    render_views

    let(:project) { Project.create!(name: "Test Project") }
    let(:user_name) { "First commenter" }

    before do
      session[:username] = user_name

      project.change_state_to!("in_progress", author: "State changing user")
      project.comments.create!(content: "First comment", author: "First commenting user")
      project.comments.create!(content: "Second comment", author: "Second user")
    end

    it "renders the project with its timeline" do
      get :show

      expect(response).to have_http_status(:ok)

      expect(response.parsed_body.at_css("#project-name").text).to eq "Test Project"
      expect(response.parsed_body.at_css("#project-state").text).to eq "in_progress"
      expect(response.parsed_body.at_css("#timeline")).to be_present
      expect(response.parsed_body.at_css("#new-comment-form")).to be_present
    end

    it "renders timeline items" do
      get :show

      expect(response.parsed_body.at_css(".comment-content").text).to include("First comment")
      expect(response.parsed_body.at_css(".comment-author").text).to include("First commenting user")

      expect(response.parsed_body.css(".timeline-item").length).to eq(3)
    end
  end
end
