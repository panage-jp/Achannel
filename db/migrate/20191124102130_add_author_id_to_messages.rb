class AddAuthorIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :autho_id, :string, default: "???"
  end
end
