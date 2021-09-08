# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'a@example.com' }
    password { 'password' }
  end
end
