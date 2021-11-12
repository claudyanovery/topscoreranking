# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    score { Faker::Number.between(from: 1, to: 10) }
    player { "Nancy" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
