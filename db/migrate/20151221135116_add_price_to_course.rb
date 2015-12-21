class AddPriceToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :prijs, :decimal
  end
end
