class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update]

  def index
    @tasks = current_user.tasks
  end

  def show
    @comments = @task.comments
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

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
      render 'edi'
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
    params.require(:task).permit(%i[name description])
  end
end
