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
require 'faker'

FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.sentence }
    association :user
    association :task
  end
end
