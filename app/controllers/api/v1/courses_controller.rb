# frozen_string_literal: true

class Api::V1::CoursesController < Api::V1Controller
  def create
    @course = Course.new(create_params)
    if @course.save
      render :show, status: :created
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @courses = Course.order(created_at: :desc).page(index_params[:page])
  end

  private
  def create_params
    params.require(:course).permit(:name, tutors_attributes: %i[name email])
  end

  def index_params
    params.permit(:page)
  end
end
