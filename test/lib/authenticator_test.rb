require 'test_helper'

class AuthenticatorTest < ActiveSupport::TestCase
  test "should get info from GitHub" do
    connection = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.post ENV['GITHUB_ACCESS_TOKEN_URL'] do
          [200, {}, JSON.generate(
            token: 'foobar'
          )]
        end
        stub.get ENV['GITHUB_USER_INFO_URL'] do
          [200, {}, JSON.generate(
            login: 'octocat',
            name: 'monalisa octocat',
            avatar_url: 'https://github.com/images/error/octocat_happy.gif'
          )]
        end
      end
    end

    authenticator = Authenticator.new(connection)

    actual = authenticator.github('code')
    expected = {
      issuer: ENV['FLASHCARDS_CLIENT_URL'],
      login: 'octocat',
      name: 'monalisa octocat',
      avatar_url: 'https://github.com/images/error/octocat_happy.gif'
    }

    assert_equal expected, actual
  end

  test "should raise if unable to get access token" do
    connection = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.post ENV['GITHUB_ACCESS_TOKEN_URL'] do
          [500, {}]
        end
      end
    end

    authenticator = Authenticator.new(connection)

    error = assert_raises(IOError) { authenticator.github('code') }
    assert_equal 'FETCH_ACCESS_TOKEN', error.message
  end

  test "should raise if unable to get user info" do
    connection = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.post ENV['GITHUB_ACCESS_TOKEN_URL'] do
          [200, {}, JSON.generate(
            token: 'foobar'
          )]
        end
        stub.get ENV['GITHUB_USER_INFO_URL'] do
          [500, {}]
        end
      end
    end

    authenticator = Authenticator.new(connection)

    error = assert_raises(IOError) { authenticator.github('code') }
    assert_equal 'FETCH_USER_INFO', error.message
  end
end
