# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user

  private

  def current_user
    return @current_user if defined? @current_user

    return nil if session[:username].blank?

    @current_user ||= User.build_from_session(session)
  end

  def authenticate_user
    redirect_to root_url if current_user.nil?
  end
end
