class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :author, default: "名無しさん"
      t.references :room
      t.integer :responce, default: 0

      t.timestamps
    end
  end
end
