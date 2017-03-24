require 'test_helper'

# Integration tests for flashcards.
class FlashcardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @token = TokiToki.encode(@user.login)
    @flashcard = @user.flashcards.first
  end

  test 'should get index' do
    get flashcards_url, params: {
      token: @token
    }
    assert_response :success
  end

  test 'should create flashcard' do
    assert_difference('Flashcard.count') do
      post flashcards_url, params: {
        token: @token,
        flashcard: {
          answer: @flashcard.answer,
          question: @flashcard.question
        }
      }, as: :json
    end

    assert_response 201
  end

  test 'should show flashcard' do
    get flashcard_url(@flashcard), params: {
      token: @token
    }
    assert_response :success
  end

  test 'should show flashcard tags' do
    get tags_flashcard_url(@flashcard), params: {
      token: @token
    }
    assert_response :success
  end

  test 'should update flashcard' do
    patch flashcard_url(@flashcard), params: {
      token: @token,
      flashcard: {
        answer: @flashcard.answer,
        question: @flashcard.question
      }
    }, as: :json
    assert_response 200
  end

  test 'should destroy flashcard' do
    assert_difference('Flashcard.count', -1) do
      delete flashcard_url(@flashcard), params: {
        token: @token
      }, as: :json
    end

    assert_response 204
  end
end
