# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :find_task, only: %i[show edit update destroy]

  def index
    @tasks = tasks
    @percent = ProgressionCalculator.call(current_user)
  end
  
  def show
    @comments = @task.comments
    respond_to do |format|
      format.html
      format.json { render json: @task }
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:notice] = 'New task has been created'
      redirect_to @task
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:notice] = 'The task has been updated'
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :done).merge(user: current_user)
  end

  def closed_tasks
    current_user.tasks.closed
  end

  def in_progress_tasks
    current_user.tasks.in_progress
  end

  def tasks
    case params[:status]
    when 'open'
      in_progress_tasks
    when 'close'
      closed_tasks
    else
      current_user.tasks
    end
  end
end
