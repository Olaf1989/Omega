class AddCourseTypeIdToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :course_types_id, :integer
    add_index  :courses, :course_types_id
  end
end
