# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]

  def new
    @user = User.build_from_session(session)
  end

  def create
    @user = User.new
    @user.assign_attributes(user_params)

    if @user.valid?
      session[:username] = @user.name
      redirect_to project_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [:name])
  end
end
