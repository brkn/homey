# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :assign_timeline_items, only: [:show]
  before_action :assign_new_comment, only: [:show]

  def show; end

  def update
    state_change = @project.change_state_to(new_state_param, author: current_user.name)

    if state_change.persisted?
      respond_to do |format|
        format.html { redirect_to project_path }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to project_path, alert: state_change.errors.full_messages.to_sentence }
        format.json { head :bad_request }
      end
    end
  end

  private

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
