class AddAuthorIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :autho_id, :integer, default: 0
  end
end
