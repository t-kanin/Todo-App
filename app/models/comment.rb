# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  task_id    :integer
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :comment, presence: true
end
