class CoursesController < ApplicationController
  # Voordat er inglogd is
  skip_before_action :require_login, only: [:index, :show]
  # Nadat er ingelogd is
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    # filterrific initialisatie
    @filterrific = initialize_filterrific(
      Course,
      params[:filterrific],
      select_options: {
        sorted_by: Course.options_for_sorted_by
      },
      persistence_id: 'shared_key',
      default_filter_params: {},
      available_filters: [],
    ) or return
    @courses = @filterrific.find.page(params[:page])
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
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
