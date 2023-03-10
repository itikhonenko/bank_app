# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@email.com" }
    password { Faker::Internet.password }

    trait :with_accounts do
      accounts { [association(:account)] }
    end
  end
end
