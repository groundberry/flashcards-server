require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  def setup
    @flashcard = flashcards(:one)
    @tag = tags(:one)
  end

  test 'flashcards for tag' do
    assert_equal 1, @tag.flashcards.size
  end

  test 'tags for flashcard' do
    assert_equal 1, @flashcard.tags.size
  end
end
