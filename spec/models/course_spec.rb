# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:tutors) }
  end

  describe 'valid' do
    it 'is valid with correct attributes' do
      expect(FactoryBot.create(:course)).to be_valid
    end
  end

  describe 'invalid' do
    it 'is invalid without name' do
      course = FactoryBot.build(:course, name: nil)
      expect(course).not_to be_valid
      expect(course.errors.full_messages[0]).to eq("Name can't be blank")
    end
  end
end