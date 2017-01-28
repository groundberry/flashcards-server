require 'test_helper'

class FlashcardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @flashcard = @user.flashcards.first
  end

  test "should get index" do
    get user_flashcards_url(@user), as: :json
    assert_response :success
  end

  test "should create flashcard" do
    assert_difference('Flashcard.count') do
      post user_flashcards_url(@user), params: { flashcard: { answer: @flashcard.answer, question: @flashcard.question, user_id: @flashcard.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show flashcard" do
    get user_flashcard_url(@user, @flashcard), as: :json
    assert_response :success
  end

  test "should update flashcard" do
    patch user_flashcard_url(@user, @flashcard), params: { flashcard: { answer: @flashcard.answer, question: @flashcard.question, user_id: @flashcard.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy flashcard" do
    assert_difference('Flashcard.count', -1) do
      delete user_flashcard_url(@user, @flashcard), as: :json
    end

    assert_response 204
  end
end
