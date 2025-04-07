# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    session[:username] = User.new(name: params[:username]).name

    redirect_to root_path
  end
end
