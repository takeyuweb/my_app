class CreateMyApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :my_api_keys, id: :uuid, comment: '暗号化サンプル' do |t|
      t.string :encrypted_key, null: false
      t.string :key_salt, null: false
      t.string :key_cipher, null: false

      t.timestamps
    end
  end
end
