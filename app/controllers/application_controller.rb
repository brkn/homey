# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user
  before_action :assign_project

  private

  def current_user
    return @current_user if defined? @current_user

    return nil if session[:username].blank?

    @current_user ||= User.build_from_session(session)
  end

  def authenticate_user
    redirect_to new_session_url if current_user.nil?
  end

  def assign_project
    @project = Project.last
  end
end
