class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :naam
      t.date :begindatum
      t.date :einddatum
      t.string :cursusduur

      t.timestamps null: false
    end
  end
end
