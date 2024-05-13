# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'POST /create' do
    let!(:valid_attributes) do
      {
        name: Faker::ProgrammingLanguage.name,
        tutors_attributes: [
          {
            name: Faker::Name.name,
            email: Faker::Internet.email
          },
          {
            name: Faker::Name.name,
            email: Faker::Internet.email
          }
        ]
      }
    end

    context 'with valid attributes' do
      it 'creates a new course' do
        post api_v1_courses_url, params: { course: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'does not creates a new course with blank params' do
        post api_v1_courses_url, params: { course: {} }, as: :json
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not creates a new course without name' do
        post api_v1_courses_url, params: { course: valid_attributes.merge!({ name: nil }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(["Name can't be blank"])
      end

      it 'does not creates a new course without tutors' do
        post api_v1_courses_url, params:
          { course: valid_attributes.merge!({ tutors_attributes: nil }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(["Tutors can't be blank"])
      end

      it 'does not creates a new course without tutors' do
        post api_v1_courses_url, params:
          { course: valid_attributes.merge!({ tutors_attributes: nil }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(["Tutors can't be blank"])
      end

      it 'does not creates a new course without tutor name' do
        post api_v1_courses_url, params: { course: valid_attributes
          .merge!({ tutors_attributes: [{ name: '', email: 'test@test.com' }] }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(["Tutors name can't be blank"])
      end

      it 'does not creates a new course without tutor email' do
        post api_v1_courses_url, params: { course: valid_attributes
          .merge!({ tutors_attributes: [{ name: 'test', email: '' }] }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(['Tutors email is invalid'])
      end

      it 'does not creates a new course with invalid tutor email' do
        post api_v1_courses_url, params: { course: valid_attributes
          .merge!({ tutors_attributes: [{ name: 'test', email: 'test' }] }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(['Tutors email is invalid'])
      end
    end
  end

  describe 'GET /index' do
    context 'fetch courses' do
      it 'with tutors in sorted order by created_at' do
        course_1 = FactoryBot.create(:course, :with_tutors)
        course_2 = FactoryBot.create(:course, :with_tutors)
        get api_v1_courses_url, as: :json
        expect(response).to be_successful
        expect(response.parsed_body['data'].size).to eq(2)

        # Course_2
        expect(response.parsed_body['data'][0]['id']).to eq(course_2.id)
        expect(response.parsed_body['data'][0]['name']).to eq(course_2.name)
        expect(response.parsed_body['data'][0]['tutors'].size).to eq(2)
        expect(response.parsed_body['data'][0]['tutors'][0]['email']).to eq(course_2.tutors.first.email)
        expect(response.parsed_body['data'][0]['tutors'][1]['email']).to eq(course_2.tutors.second.email)
        # Course_1
        expect(response.parsed_body['data'][1]['id']).to eq(course_1.id)
        expect(response.parsed_body['data'][1]['name']).to eq(course_1.name)
        expect(response.parsed_body['data'][1]['tutors'].size).to eq(2)
        expect(response.parsed_body['data'][1]['tutors'][0]['email']).to eq(course_1.tutors.first.email)
        expect(response.parsed_body['data'][1]['tutors'][1]['email']).to eq(course_1.tutors.second.email)
      end

      context 'with pagination' do
        let!(:courses) { 11.times { FactoryBot.create(:course, :with_tutors) } }

        it 'courses' do
          expect(Course.count).to eq(11)
          get '/api/v1/courses?page=1', as: :json
          expect(response).to be_successful
          expect(response.parsed_body['data'].size).to eq(10)

          get '/api/v1/courses?page=2', as: :json
          expect(response).to be_successful
          expect(response.parsed_body['data'].size).to eq(1)
        end
      end
    end
  end
end
