class TasksController < ApplicationController
  include JwtAuthenticator
  before_action :jwt_authenticate

  def index
    render json: @current_user.tasks.all
  end

  def show
    render json: @current_user.tasks.find(params[:id])
  end

  def create
    task = @current_user.tasks.new(task_params)
    if task.save
      render json: task
    else
      render json: task.errors
    end
  end

  def update
    task = @current_user.tasks.find(params[:id])
    if task.update(task_params)
      render json: task
    else
      render json: task.errors
    end
  end

  def destroy
    task = @current_user.tasks.find(params[:id])
    task.destroy!
    render json: task
  end

  private

  def task_params
    params.require(:task).permit(:id, :title, :done)
  end
end
