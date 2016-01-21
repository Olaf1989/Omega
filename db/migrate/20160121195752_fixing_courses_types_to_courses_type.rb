class FixingCoursesTypesToCoursesType < ActiveRecord::Migration
  def change
    remove_column :courses, :course_types_id, :integer

    add_column :courses, :course_type_id, :integer
    add_index  :courses, :course_type_id
  end
end
