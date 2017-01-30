class User < ApplicationRecord
  has_many :flashcards, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :name, presence: true
  validates :login, presence: true, uniqueness: true
end
