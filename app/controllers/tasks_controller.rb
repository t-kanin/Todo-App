class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'The new task has been created'
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

  private

  def find_task
    @task = Task.find(paramms[:id])
  end

  def task_params
    params.require(:task).permit(:name)
  end
end
