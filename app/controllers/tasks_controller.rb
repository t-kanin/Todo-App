# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :find_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks
    @percent = calcualte_progression
  end

  def index_open_tasks
    @tasks = current_user.tasks.tasks_open?
    respond_to do |format|
      format.html
      format.json { render json: @tasks }
    end
  end

  def index_close_tasks
    @tasks = current_user.tasks.tasks_open?(true)
    respond_to do |format|
      format.html
      format.json { render json: @tasks }
    end
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
    params.require(:task).permit([:name, :description, :done])
  end

  def calcualte_progression
    return 0 if current_user.tasks.count.zero?

    ((current_user.tasks.tasks_open?(true).count.to_f / current_user.tasks.count) * 100).to_i
  end
end
