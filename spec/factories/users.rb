# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    password_confirmation { password }

    trait :admin do
      admin { true }
    end
  end
end
