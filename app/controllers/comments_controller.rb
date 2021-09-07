class CommentsController < ApplicationController
  before_action :find_task, only: %i[create]

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
