require 'test_helper'

class FlashcardTest < ActiveSupport::TestCase
  def setup
    @flashcard = flashcards(:one)
  end

  test 'valid flashcard' do
    assert @flashcard.valid?
  end

  test 'invalid without question' do
    flashcard = Flashcard.new(user: @flashcard.user, answer: 'Answer 1')
    refute flashcard.valid?
    assert_not_nil flashcard.errors[:question]
  end

  test 'invalid without answer' do
    flashcard = Flashcard.new(user: @flashcard.user, question: 'Question 1')
    refute flashcard.valid?
    assert_not_nil flashcard.errors[:answer]
  end
end
