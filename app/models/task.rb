class Task < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }

  belongs_to :user
  has_many :comments, dependent: :destroy
end
