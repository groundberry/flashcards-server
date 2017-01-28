class FlashcardsController < ApplicationController
  before_action :set_user
  before_action :set_flashcard, only: [:show, :update, :destroy]

  # GET /users/1/flashcards
  def index
    @flashcards = @user.flashcards

    render json: @flashcards
  end

  # GET /users/1/flashcards/1
  def show
    render json: @flashcard
  end

  # POST /users/1/flashcards
  def create
    @flashcard = Flashcard.new(flashcard_params)

    if @flashcard.save
      render json: @flashcard, status: :created, location: [@user, @flashcard]
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

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_flashcard
    @flashcard = @user.flashcards.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def flashcard_params
    params.require(:flashcard).permit(:user_id, :question, :answer)
  end
end
