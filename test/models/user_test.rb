require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without a name' do
    @user.name = nil
    refute @user.valid?
    assert_not_nil @user.errors[:name]
  end

  test 'invalid without an email' do
    @user.email = nil
    refute @user.valid?
    assert_not_nil @user.errors[:email]
  end

  test 'invalid if email already exists' do
    user = User.new(email: @user.email, name: 'Someone Else')
    refute user.valid?
    assert_not_nil user.errors[:email]
  end

  test '#flashcards' do
    assert_equal 2, @user.flashcards.size
  end

  test '#tags' do
    assert_equal 2, @user.tags.size
  end
end
