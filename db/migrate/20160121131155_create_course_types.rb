class CreateCourseTypes < ActiveRecord::Migration
  def change
    create_table :course_types do |t|
      t.string :name
      t.decimal :price

      t.timestamps null: false
    end
    remove_column :courses, :naam
    remove_column :courses, :prijs
  end
end
