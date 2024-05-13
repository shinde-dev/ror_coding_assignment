# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :tutors, dependent: :nullify

  validates :name, :tutors, presence: true
  accepts_nested_attributes_for :tutors
end
