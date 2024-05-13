# frozen_string_literal: true

FactoryBot.define do
  factory :tutor do
    course
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
