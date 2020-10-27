class Book < ApplicationRecord
  belongs_to :author
  has_many :book_subjects
  has_many :subjects, through: :book_subjects

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :number_of_pages, numericality: { only_integer: true }
  validates :rating, numericality: true
end
