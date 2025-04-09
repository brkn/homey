# frozen_string_literal: true

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource :session, only: [:new, :create]

  resource :project, only: [:show, :update] do
    resources :comments, only: [:create]
  end

  root to: "projects#show"

  resolve("Project") { [:project] }
end
