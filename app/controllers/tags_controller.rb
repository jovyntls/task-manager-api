class TagsController < ApplicationController
  before_action :authorized

  # GET /tags
  def index
    @tasks = Tag.where(user_id: @user.id).order('title')

    render json: @tags
  end

  # GET /tags/1
  def show
    @task = Tag.where(id: params[:id])

    render json: @tag
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    @tag.user_id = @user.id

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    @task = Tag.where(id: params[:id])
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    Tag.destroy(params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tag_params
    params.permit(:title, :user_id)
  end
end
