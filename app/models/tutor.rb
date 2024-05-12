# frozen_string_literal: true

class Tutor < ApplicationRecord
  belongs_to :course, optional: true

  validates :email, uniqueness: true
end
