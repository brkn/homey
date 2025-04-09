# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :assing_project
  before_action :assign_timeline_items
  before_action :assign_new_comment

  def show; end

  private

  def assing_project
    @project = Project.last
  end

  def assign_timeline_items
    @timeline_items = (@project.comments.to_a + @project.state_changes.to_a).sort_by(&:created_at)
  end

  def assign_new_comment
    @new_comment = Comment.new
  end
end
