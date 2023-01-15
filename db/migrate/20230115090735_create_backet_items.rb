class CreateBacketItems < ActiveRecord::Migration[7.0]
  def change
    create_table :backet_items, id: :uuid do |t|
      t.references :backet, null: false, foreign_key: true, type: :uuid
      t.references :item, null: false, foreign_key: true, type: :uuid
      t.index %i[backet_id item_id], unique: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
