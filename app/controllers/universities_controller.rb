class UniversitiesController < ApplicationController
  def index
    @universities = University.order('total_enrollment_2011 desc')
  end

  def show
    @university = University.find(params[:id])
  end
end
