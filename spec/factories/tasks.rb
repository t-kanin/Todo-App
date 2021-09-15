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
FactoryBot.define do
  factory :task do
    sequence(:name) { |n| Faker::Lorem.sentence(word_count: 3) + "-#{n}" }
    done { false }
    description { Faker::Lorem.sentence }
    association :user
  end
end
