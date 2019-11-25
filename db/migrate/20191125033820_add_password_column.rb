class AddPasswordColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :password, :integer
    add_column :rooms, :password, :integer
  end
end
