# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController do
  describe "GET #new" do
    render_views

    it "renders a login form" do
      get :new

      expect(response).to have_http_status(:ok)
      expect(response.body).to include "Join project"
    end
  end

  describe "POST /create" do
    context "with valid username" do
      it "sets the username in the session" do
        post :create, params: { user: { name: "testuser" } }

        expect(session[:username]).to eq("testuser")
      end
    end

    context "with invalid username" do
      it "does not set the username in the session" do
        post :create, params: { user: { name: "" } }
        expect(session[:username]).to be_nil
      end

      it "renders the new template with an error" do
        post :create, params: { user: { name: "" } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
