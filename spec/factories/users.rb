# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "woof-SAYS-muffi" }
    password_confirmation { password }

    trait :admin do
      admin { true }
    end
  end
end
