# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @project.comments.create(comment_params)

    if @comment.persisted?
      redirect_to project_path
    else
      redirect_to project_path, alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def comment_params
    params.expect(comment: [:content])
          .merge(author: current_user.name)
  end
end
