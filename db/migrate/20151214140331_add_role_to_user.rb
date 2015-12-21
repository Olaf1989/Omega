class AddRoleToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.column :rol, :integer, default: 0
    end
  end
end
