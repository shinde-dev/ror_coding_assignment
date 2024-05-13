# frozen_string_literal: true

json.extract!(
  course,
  :id,
  :name
)
json.tutors course.tutors, :name, :email
