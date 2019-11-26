class AddClientIpColumnToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :client_ip, :string, default: "???"
  end
end
