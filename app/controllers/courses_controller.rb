class CoursesController < ApplicationController
  # Voordat er inglogd is
  skip_before_action :require_login, only: [:index, :show]
  # Nadat er ingelogd is
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    authorize! :manage, Course
    @course = Course.new
  end

  def edit
    authorize! :manage, Course
  end

  def create
    authorize! :manage, Course
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Cursus is succesvol aangemaakt.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :manage, Course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Cursus is succesvol gewijzigd.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :manage, Course
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Cursus is succesvol verwijderd.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:begindatum, :einddatum, :cursusduur, :course_type_id)
    end
end
