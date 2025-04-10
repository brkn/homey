# frozen_string_literal: true

require "rails_helper"

RSpec.describe CommentsController do
  describe "POST #create" do
    let!(:project) { Project.create!(name: "Test Project") }
    let(:comment) { Comment.last }
    let(:user_name) { "Commenting_user" }
    let(:valid_comment_params) { { comment: { content: "This is a test comment" } } }

    before do
      session[:username] = user_name
    end

    it "creates a comment associated with the current project and user" do
      expect do
        post :create, params: valid_comment_params
      end.to change(Comment, :count).by(1)

      expect(comment.content).to eq("This is a test comment")
      expect(comment.author).to eq(user_name)
      expect(comment.project).to eq(project)
    end

    it "redirects to the project page after creating a comment" do
      post :create, params: valid_comment_params

      expect(response).to redirect_to(project_path)
    end

    context "with invalid params" do
      it "does not create a comment" do
        expect do
          post :create, params: { comment: { content: "" } }
        end.not_to change(Comment, :count)
      end

      it "renders the project page with an error" do
        post :create, params: { comment: { content: "" } }

        expect(response).to redirect_to(project_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
