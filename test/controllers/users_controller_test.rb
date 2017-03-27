require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @token = TokiToki.encode(@user.login)
  end

  test "should show user details" do
    get user_url, params: {
      token: @token
    }
    assert_response :success
  end

end
