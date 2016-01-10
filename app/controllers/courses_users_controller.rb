class CoursersUsersController < ApplicationController
    def new
      @course = Course.find params[:course_id]
      @course_user = Course_user.new({course: course})
    end

    def create
      @course = Course.find_by_name[:course]
      @course_user = current_user.course_user.build(params[:course_user])
      if @course_user.save
        flash[:notice] = "You have joined this course."
        redirect_to :back
      else
        flash[:error] = "Unable to join."
        redirect_to :back
      end
    end

    private

    def course_user_params
        params.require(:course_user).merge(course_id: params[:course_id], user_id: current_user.id)
    end
end
