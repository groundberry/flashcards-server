class User < ApplicationRecord
  has_many :flashcards, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :name, presence: true
  validates :login, presence: true, uniqueness: true

  after_commit :add_seed_data, on: :create

  private

  def add_seed_data
    seed_file = File.read(Rails.root.join('db', 'seeds', 'flashcards.yml'))
    seed_data = YAML.safe_load(seed_file)

    flashcards = seed_data.map do |flashcard|
      tags = flashcard['tags'].map do |tag|
        Tag.find_or_create_by!(
          user: self,
          name: tag
        )
      end

      Flashcard.new(
        user: self,
        question: flashcard['question'],
        answer: flashcard['answer'],
        tags: tags
      )
    end

    self.flashcards.push(flashcards)
  end
end
