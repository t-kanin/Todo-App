class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks
    @percent = ((task_close.count.to_f / @tasks.count) * 100).to_i
  end

  def index_open_tasks
    @tasks = task_open
  end

  def index_close_tasks
    @tasks = task_close
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
    params.require(:task).permit(%i[name description done])
  end

  def task_open
    current_user.tasks.where(done: false)
  end

  def task_close
    current_user.tasks.where(done: true)
  end
end
