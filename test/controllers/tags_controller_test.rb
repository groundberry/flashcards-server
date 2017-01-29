require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @tag = @user.tags.first
  end

  test "should get index" do
    get user_tags_url(@user), as: :json
    assert_response :success
  end

  test "should create tag" do
    assert_difference('Tag.count') do
      post user_tags_url(@user), params: { tag: {
        name: 'Some Tag',
        user_id: @tag.user_id
      } }, as: :json
    end

    assert_response 201
  end

  test "should show tag" do
    get user_tag_url(@user, @tag), as: :json
    assert_response :success
  end

  test "should update tag" do
    patch user_tag_url(@user, @tag), params: { tag: {
      name: 'Some Tag',
      user_id: @tag.user_id
    } }, as: :json
    assert_response 200
  end

  test "should destroy tag" do
    assert_difference('Tag.count', -1) do
      delete user_tag_url(@user, @tag), as: :json
    end

    assert_response 204
  end
end
