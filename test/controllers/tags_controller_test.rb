require 'test_helper'

# Integration tests for tags.
class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @token = TokiToki.encode(@user.login)
    @tag = @user.tags.first
  end

  test 'should get index' do
    get tags_url, params: {
      token: @token
    }
    assert_response :success
  end

  test 'should create tag' do
    assert_difference('Tag.count') do
      post tags_url, params: {
        token: @token,
        tag: {
          name: 'Some Tag',
          user_id: @tag.user_id
        }
      }, as: :json
    end

    assert_response 201
  end

  test 'should show tag' do
    get tag_url(@tag), params: {
      token: @token
    }
    assert_response :success
  end

  test 'should show tag flashcards' do
    get flashcards_tag_url(@tag), params: {
      token: @token
    }
    assert_response :success
  end

  test 'should update tag' do
    patch tag_url(@tag), params: {
      token: @token,
      tag: {
        name: 'Some Tag',
        user_id: @tag.user_id
      }
    }, as: :json
    assert_response 200
  end

  test 'should destroy tag' do
    assert_difference('Tag.count', -1) do
      delete tag_url(@tag), params: {
        token: @token
      }, as: :json
    end

    assert_response 204
  end
end
