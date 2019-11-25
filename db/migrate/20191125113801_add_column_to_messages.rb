class AddColumnToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :deleted_or_edited, :integer, default: 0
  end
end
