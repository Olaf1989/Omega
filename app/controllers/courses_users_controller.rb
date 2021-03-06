class CoursesUsersController < ApplicationController
  def new
    @course = Course.find params[:course_id]
    @course_user = Course_user.new({course: course})
  end

  def create
    @course = Course.find params[:course_id]
    @course_user = current_user.courses_users.build(course: @course)
    @existing_course_user = CoursesUser.where course: @course.id, user: current_user.id # Dit is een lelijke oplossing, maar werkt wel! :)
    if @existing_course_user.exists? # Als de relatie bestaat, dan wordt deze verwijderd.
      if @existing_course_user.destroy_all # Destroy_all is puur voor het geval dat er een duplicatie van de courses_user is.
        flash[:notice] = "U bent afgemeld voor de cursus."
        redirect_to :back
      else
        flash[:notice] = "Afmelden niet gelukt."
        redirect_to :back
      end
    else # Als de relatie niet bestaat, dan wordt deze aangemaakt.
      if @course_user.save
        flash[:notice] = "U bent aangemeld voor de cursus."
        redirect_to :back
      else
        flash[:error] = "Aanmelden niet gelukt."
        redirect_to :back
      end
    end
  end

  private
  def course_user_params
      params.require(:courses_users).permit(:course_id)
  end
end
