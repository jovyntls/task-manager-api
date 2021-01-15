class TasksController < ApplicationController
  before_action :authorized  # , :set_task, only: %i[show update destroy]

  # GET /tasks
  def index
    @tasks = Task.where(user_id: @user.id).order('created_at')

    render json: @tasks
  end

  # GET /tasks/1
  def show
    @task = Task.where(id: params[:id])

    render json: @task
  end

  # GET /tasks/cat/1
  def catid
    @task = Task.where(user_id: @user.id).where(cat_id: params[:cat_id]).order('created_at')

    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = @user.id

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    @task = Task.where(id: params[:id])
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    Task.destroy(params[:id])
  end

  # DELETE /tasks/completed/cat_id
  def clearcompleted
    Task.where(cat_id: params[:cat_id]).where(completed: true).destroy_all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def task_params
    params.permit(:title, :user_id, :cat_id, :completed, :task, :priority)
    # params.require(:task).permit(:title, :user_id)
  end
end
