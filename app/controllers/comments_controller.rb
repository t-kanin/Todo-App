# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :find_task, only: %i[index create]

  def index
    @comments = @task.comments
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @task.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Commment has been saved'
      redirect_to @task
    else
      render 'new'
    end
  end
end

private

def find_task
  @task = Task.find(params[:task_id])
end

def comment_params
  params.require(:comment).permit(:comment)
end
