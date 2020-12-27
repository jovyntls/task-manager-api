class ItemsTagsController < ApplicationController
  before_action :authorized  # :set_items_tag, only: %i[show update destroy]

  # GET /items_tags
  def index
    @items_tags = ItemsTag.where(user_id: @user.id)

    render json: @items_tags
  end

  # GET /items_tags/1
  def show
    @items_tag = ItemsTag.where(id: params[:id])
    render json: @items_tag
  end

  # GET /items_tags/by_cat/1
  def catid
    @items_tag = ItemsTag.where(cat_id: params[:cat_id])
    render json: @items_tag
  end

  # GET /items_tags/by_tag/1
  def tagid
    @items_tag = ItemsTag.where(tag_id: params[:tag_id])
    render json: @items_tag
  end

  # POST /items_tags
  def create
    @items_tag = ItemsTag.new(items_tag_params)
    @items_tag.user_id = @user.id

    if @items_tag.save
      render json: @items_tag, status: :created, location: @items_tag
    else
      render json: @items_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items_tags/1
  def destroy
    ItemsTag.destroy(params[:id])
  end

  # DELETE /items_tags/:tag_id/:cat_id
  def remove
    ItemsTag.where(tag_id: params[:tag_id]).where(cat_id: params[:cat_id]).destroy_all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_items_tag
    @items_tag = ItemsTag.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def items_tag_params
    params.permit(:tag_id, :cat_id, :user_id)
  end
end
