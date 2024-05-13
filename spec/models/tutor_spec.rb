# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutor, type: :model do
  describe 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:course).optional(true) }
  end

  describe 'is valid' do
    it 'with correct attributes' do
      expect(FactoryBot.create(:tutor)).to be_valid
    end
  end

  describe 'is invalid' do
    it 'without name' do
      tutor = FactoryBot.build(:tutor, name: nil)
      expect(tutor).not_to be_valid
      expect(tutor.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it 'without email' do
      tutor = FactoryBot.build(:tutor, email: nil)
      expect(tutor).not_to be_valid
      expect(tutor.errors.full_messages[0]).to eq('Email is invalid')
    end

    it 'with duplicate email' do
      tutor1 = FactoryBot.create(:tutor)
      tutor = FactoryBot.build(:tutor, email: tutor1.email)
      expect(tutor).not_to be_valid
      expect(tutor.errors.full_messages[0]).to eq('Email has already been taken')
    end

    it 'with invalid email' do
      tutor = FactoryBot.build(:tutor, email: 'email')
      expect(tutor).not_to be_valid
      expect(tutor.errors.full_messages[0]).to eq('Email is invalid')
    end
  end
end
