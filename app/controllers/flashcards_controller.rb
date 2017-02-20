# Flashcards controller.
class FlashcardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_flashcard, only: [:show, :tags, :update, :destroy]

  # GET /users/1/flashcards
  def index
    @flashcards = @current_user.flashcards

    render json: @flashcards
  end

  # GET /users/1/flashcards/1
  def show
    render json: @flashcard
  end

  # GET /users/1/flashcards/1/tags
  def tags
    render json: @flashcard.tags
  end

  # POST /users/1/flashcards
  def create
    @flashcard = Flashcard.new(flashcard_params)

    if @flashcard.save
      render json: @flashcard, status: :created, location: @flashcard
    else
      render json: @flashcard.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1/flashcards/1
  def update
    if @flashcard.update(flashcard_params)
      render json: @flashcard
    else
      render json: @flashcard.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1/flashcards/1
  def destroy
    @flashcard.destroy
  end

  private

  def set_flashcard
    @flashcard = @current_user.flashcards.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def flashcard_params
    params.require(:flashcard).permit(:user_id, :question, :answer)
  end
end
