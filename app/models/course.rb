# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :tutors, dependent: :nullify
end
