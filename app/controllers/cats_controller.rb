class CatsController < ApplicationController
  before_action :authorized  # , :set_cat, only: [:show, :update, :destroy]

  # GET /cats
  def index
    @cats = Cat.where(user_id: @user.id)

    render json: @cats
  end

  # GET /cats/1
  def show
    @cat = Cat.where(id: params[:id])

    render json: @cat
  end

  # POST /cats
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = @user.id

    if @cat.save
      render json: @cat, status: :created, location: @cat
    else
      render json: @cat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cats/1
  def update
    @cat = Cat.where(id: params[:id])
    if @cat.update(cat_params)
      render json: @cat
    else
      render json: @cat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cats/1
  def destroy
    Task.where(cat_id: params[:id]).destroy_all
    Cat.destroy(params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cat
    @cat = Cat.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def cat_params
    params.permit(:title, :user_id)
    # params.require(:cat).permit(:title, :user_id)
  end
end
