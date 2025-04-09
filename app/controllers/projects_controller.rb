# frozen_string_literal: true

class ProjectsController < ApplicationController
  def show
    render plain: current_user.name
  end
end
