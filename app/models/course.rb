# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :tutors, dependent: :nullify

  validates :name, presence: true
  accepts_nested_attributes_for :tutors
end
