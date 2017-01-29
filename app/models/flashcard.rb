class Flashcard < ApplicationRecord
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :question, presence: true
  validates :answer, presence: true
end
