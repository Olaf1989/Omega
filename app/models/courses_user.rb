class CoursesUser < ActiveRecord::Base

  belongs_to :course
  belongs_to :user

  def course_naam
    if self.group
      @course_naam ||= self.course.naam
    end
  end

  def course_naam=(course_naam)
    @course_naam = course_naam

    self.course = Course.find_by_naam(@course_naam)
  end
end
