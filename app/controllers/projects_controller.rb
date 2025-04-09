# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :assign_project
  before_action :assign_timeline_items, only: [:show]
  before_action :assign_new_comment, only: [:show]

  def show; end

  def update
    state_change = @project.change_state_to(new_state_param, author: current_user.name)

    if state_change.persisted?
      head :ok
    else
      head :bad_request
    end
  end

  private

  def assign_project
    @project = Project.last
  end

  def assign_timeline_items
    @timeline_items = (@project.comments.to_a + @project.state_changes.to_a).sort_by(&:created_at)
  end

  def assign_new_comment
    @new_comment = Comment.new
  end

  def new_state_param
    params.expect(project: [:state]).fetch(:state)
  end
end
