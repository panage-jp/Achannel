class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :author
      t.reference :room
      t.integer :responce

      t.timestamps
    end
  end
end
