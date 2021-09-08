FactoryBot.define do
  factory :task do
    name { 'My Task' }
    done { false }
    description { 'I want to do something' }
  end
end
