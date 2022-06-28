class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :prototypes

  validates :content, presence: true

end
