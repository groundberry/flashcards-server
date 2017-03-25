# Flashcards controller.
class FlashcardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_flashcard, only: [:show, :tags, :update, :destroy]

  # GET /flashcards
  def index
    @flashcards = @current_user.flashcards

    render json: @flashcards, include: :tags
  end

  # GET /flashcards/1
  def show
    render json: @flashcard, include: :tags
  end

  # GET /flashcards/1/tags
  def tags
    render json: @flashcard.tags
  end

  # POST /flashcards
  def create
    @flashcard = Flashcard.new(flashcard_params)
    @flashcard.user = @current_user

    if @flashcard.save
      render json: @flashcard, include: :tags, status: :created, location: @flashcard
    else
      render json: @flashcard.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /flashcards/1
  def update
    if @flashcard.update(flashcard_params)
      render json: @flashcard, include: :tags
    else
      render json: @flashcard.errors, status: :unprocessable_entity
    end
  end

  # DELETE /flashcards/1
  def destroy
    @flashcard.destroy
  end

  private

  def set_flashcard
    @flashcard = @current_user.flashcards.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def flashcard_params
    tmp_params = params.require(:flashcard).permit(:question, :answer, tags: [])
    unless tmp_params[:tags].nil?
      tmp_params[:tags].map! do |tag|
        Tag.find_or_create_by!(user: @current_user, name: tag)
      end
    end
    tmp_params
  end
end
