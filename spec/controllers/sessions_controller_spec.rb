# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController do
  describe "POST /create" do
    context "with valid username" do
      it "sets the username in the session" do
        post :create, params: { username: "testuser" }

        expect(session[:username]).to eq("testuser")
      end
    end
  end
end
