# frozen_string_literal: true

json.data do
  json.array! @courses, partial: 'course', as: :course
end
