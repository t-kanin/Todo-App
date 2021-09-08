FactoryBot.define do
  factory :comment do
    comment { 'My Comment' }
    association :user
    association :task
  end
end
