# Tags controller.
class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:show, :flashcards, :update, :destroy]

  # GET /users/1/tags
  def index
    @tags = @current_user.tags

    render json: @tags
  end

  # GET /users/1/tags/1
  def show
    render json: @tag
  end

  # GET /users/1/tags/1/flashcards
  def flashcards
    render json: @tag.flashcards
  end

  # POST /users/1/tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1/tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1/tags/1
  def destroy
    @tag.destroy
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tag_params
    params.require(:tag).permit(:user_id, :name)
  end
end
