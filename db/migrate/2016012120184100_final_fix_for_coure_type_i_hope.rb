class FinalFixForCoureTypeIHope < ActiveRecord::Migration
  def change
    add_reference :course_types, :course, index: true
    add_foreign_key :course_types, :course
  end
end
