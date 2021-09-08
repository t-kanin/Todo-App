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
FactoryBot.define do
  factory :comment do
    comment { 'My Comment' }
    association :user
    association :task
  end
end
