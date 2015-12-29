class CreateCoursesUsers < ActiveRecord::Migration
  def self.up
    create_table :courses_users, id: false do |t|
    t.references :course, null: false
    t.references :user, null: false
  end

  # Add an unique index for better join speed!
  add_index(:courses_users, [:user_id, :course_id], :unique => true)
  end

  def self.down
    drop_table :courses_users
  end
end
