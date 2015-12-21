class AddAditionalFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :voornaam, :string
    add_column :users, :tussenvoegsel, :string
    add_column :users, :achternaam, :string
    add_column :users, :adres, :string
    add_column :users, :woonplaats, :string
    add_column :users, :telefoon, :string

    remove_column :users, :rol
  end
end
