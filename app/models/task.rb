# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  done        :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  user_id     :integer
#
class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }

  scope :in_progress, -> { where(done: false) }
  scope :closed, -> { where(done: true) }
end
