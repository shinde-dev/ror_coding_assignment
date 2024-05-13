# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { Faker::ProgrammingLanguage.name }

    trait :with_tutors do
      tutors { build_list :tutor, 2 }
    end
  end
end
