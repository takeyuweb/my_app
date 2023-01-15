class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items, id: :uuid do |t|
      t.string :name, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
