class Prototype < ApplicationRecord
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :imag, presence: true
  
  has_many :comments

  belongs_to :user
  has_one_attached :imag
end
