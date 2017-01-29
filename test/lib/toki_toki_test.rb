require 'test_helper'

class TokiTokiTest < ActiveSupport::TestCase
  test "should encode into token" do
    token = TokiToki.encode 'octocat'
    assert token.include? 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9'
  end

  test "should decode from token" do
    token = TokiToki.encode 'octocat'
    decoded_token = TokiToki.decode token
    assert_equal 'octocat', decoded_token[0]['sub']
  end
end