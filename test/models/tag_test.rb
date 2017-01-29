require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def setup
    @tag = tags(:one)
    @another_user = users(:two)
  end

  test 'valid tag' do
    assert @tag.valid?
  end

  test 'invalid without name' do
    tag = Tag.new(user: @tag.user)
    refute tag.valid?
    assert_not_nil tag.errors[:name]
  end

  test 'invalid if name already exists' do
    tag = Tag.new(user: @tag.user, name: @tag.name)
    refute tag.valid?
    assert_not_nil tag.errors[:name]
  end

  test 'valid if name already exists but for another user' do
    tag = Tag.new(user: @another_user, name: @tag.name)
    assert tag.valid?
  end
end
